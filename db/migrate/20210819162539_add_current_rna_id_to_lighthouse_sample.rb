# frozen_string_literal: true

# Migration to include new columns for the most current RNA ID and populate
# reconstructed values from existing data.
class AddCurrentRnaIdToLighthouseSample < ActiveRecord::Migration[6.0]
  def self.up
    change_table :lighthouse_sample, bulk: true do |t|
      t.string :current_rna_id, null: true, default: nil, comment: 'Current rna_id value for this sample'
      t.boolean :is_current, null: false, default: false, comment: 'Identifies if this sample has the most up to date information for the same rna_id'

      t.index %i[current_rna_id], unique: true # same uniqueness criteria as in MongoDB
      t.index %i[is_current], unique: false # same uniqueness criteria as in MongoDB
    end

    execute %{
      UPDATE
        lighthouse_sample AS lsample,
        (
          SELECT
            temp_lsample.id,
            IF(most_recent_samples.most_recent_id IS NULL, 0, 1) AS is_current,
            IF(most_recent_samples.most_recent_id IS NULL, NULL, temp_lsample.rna_id) AS current_rna_id
          FROM lighthouse_sample AS temp_lsample
          LEFT JOIN (
            SELECT rna_id, max(id) AS most_recent_id
            FROM lighthouse_sample
            GROUP BY rna_id
          ) AS most_recent_samples
          ON temp_lsample.rna_id=most_recent_samples.rna_id AND temp_lsample.id=most_recent_samples.most_recent_id
        ) AS updated_data
      SET lsample.is_current=updated_data.is_current, lsample.current_rna_id=updated_data.current_rna_id
      WHERE lsample.id=updated_data.id;
    }
  end

  def self.down
    change_table :lighthouse_sample, bulk: true do |t|
      t.remove_index %i[current_rna_id]
      t.remove_index %i[is_current]

      t.remove :current_rna_id
      t.remove :is_current
    end
  end
end
