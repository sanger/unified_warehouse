# frozen_string_literal: true

# Migration to include new columns for the most current RNA ID and populate
# reconstructed values from existing data.
class AddCurrentRnaIdToLighthouseSample < ActiveRecord::Migration[6.0]
  def self.up
    # Add columns for boolean is_current and current RNA ID.
    change_table :lighthouse_sample, bulk: true do |t|
      t.boolean :is_current, null: false, default: false, comment: 'Identifies if this sample has the most up to date information for the same rna_id'
      t.index %i[is_current], unique: false # same uniqueness criteria as in MongoDB

      # current_rna_id is a function of rna_id and is_current, so create it as a virtual column
      # This way no users of this table need to concern themselves with keeping this column in sync with the others
      t.virtual :current_rna_id, type: :string, as: 'if((is_current = 1),rna_id,NULL)', stored: true
      t.index %i[current_rna_id], unique: true # same uniqueness criteria as in MongoDB
    end

    # Infer and populate historic values for is_current.
    execute %{
      UPDATE
        lighthouse_sample AS lsample,
        (
          SELECT
            temp_lsample.id,
            IF(most_recent_samples.most_recent_id IS NULL, 0, 1) AS is_current
          FROM lighthouse_sample AS temp_lsample
          LEFT JOIN (
            SELECT rna_id, max(id) AS most_recent_id
            FROM lighthouse_sample
            GROUP BY rna_id
          ) AS most_recent_samples
          ON temp_lsample.rna_id=most_recent_samples.rna_id
            AND temp_lsample.id=most_recent_samples.most_recent_id
        ) AS updated_data
      SET lsample.is_current=updated_data.is_current
      WHERE lsample.id=updated_data.id;
    }
  end

  def self.down
    # Drop index and column for current_rna_id.
    change_table :lighthouse_sample, bulk: true do |t|
      t.remove_index %i[current_rna_id]
      t.remove :current_rna_id
    end

    # Drop index and column for is_current.
    change_table :lighthouse_sample, bulk: true do |t|
      t.remove_index %i[is_current]
      t.remove :is_current
    end
  end
end
