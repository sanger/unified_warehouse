# frozen_string_literal: true

# Migration to include new columns for the most current RNA ID and populate
# reconstructed values from existing data.
class AddCurrentRnaIdToLighthouseSample < ActiveRecord::Migration[6.0]
  def self.up
    # Add column for boolean is_current.
    change_table :lighthouse_sample, bulk: true do |t|
      t.boolean :is_current, null: false, default: false, comment: 'Identifies if this sample has the most up to date information for the same rna_id'
    end

    # Infer and populate historic values for is_current.
    execute %{
      UPDATE lhs_short SET is_current = true
      WHERE id IN (
        SELECT a.max_id FROM (
          SELECT rna_id, max(id) AS max_id
            FROM lhs_short
            GROUP BY rna_id
        ) AS a
      );
    }

    # Add a generated stored column to display the RNA ID if a row is the current entry.
    change_table :lighthouse_sample, bulk: true do |t|
      # current_rna_id is a function of rna_id and is_current, so create it as a virtual column
      # This way no users of this table need to concern themselves with keeping this column in sync with the others
      t.virtual :current_rna_id, type: :string, as: 'if((is_current = 1),rna_id,NULL)', stored: true
      t.index %i[current_rna_id], unique: true # same uniqueness criteria as in MongoDB
    end
  end

  def self.down
    # Drop index and column for current_rna_id.
    change_table :lighthouse_sample, bulk: true do |t|
      t.remove_index %i[current_rna_id]
      t.remove :current_rna_id
    end

    # Drop column for is_current.
    change_table :lighthouse_sample do |t|
      t.remove :is_current
    end
  end
end
