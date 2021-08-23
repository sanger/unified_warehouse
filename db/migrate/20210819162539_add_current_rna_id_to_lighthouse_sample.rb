# frozen_string_literal: true

# Migration to include new columns for the most current RNA ID and populate
# reconstructed values from existing data.
class AddCurrentRnaIdToLighthouseSample < ActiveRecord::Migration[6.0]
  def self.up
    # Add a column for boolean value indicating the current RNA ID for a sample.
    change_table :lighthouse_sample, bulk: true do |t|
      t.boolean :is_current, null: false, default: false, comment: 'Identifies if this sample has the most up to date information for the same rna_id'
      t.index %i[is_current], unique: false # same uniqueness criteria as in MongoDB
    end

    # Add a generated column for the current RNA ID.
    execute %{
      ALTER TABLE lighthouse_sample
      ADD COLUMN current_rna_id VARCHAR(255)
      GENERATED ALWAYS AS (IF(is_current = 1, rna_id, NULL))
      STORED;
    }

    # Add an index for the generated column
    execute %{
      CREATE UNIQUE INDEX index_lighthouse_sample_on_current_rna_id
      ON lighthouse_sample (current_rna_id);
    }

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
    # Drop the index for current RNA ID.
    execute %{
      DROP INDEX index_lighthouse_sample_on_current_rna_id
      ON lighthouse_sample;
    }

    # Drop the generated column for current RNA ID.
    execute %{
      ALTER TABLE lighthouse_sample
      DROP COLUMN current_rna_id;
    }

    # Drop index and column for is_current.
    change_table :lighthouse_sample, bulk: true do |t|
      t.remove_index %i[is_current]
      t.remove :is_current
    end
  end
end
