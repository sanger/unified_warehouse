# frozen_string_literal: true

# Update to select the current sample active for rna_id
class UpdateCurrentRnaId < ActiveRecord::Migration[6.0]
  def self.up
    execute %{
        UPDATE lighthouse_sample AS lsample,
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
        WHERE  lsample.id=updated_data.id;
      }
  end

  def self.down
    execute %(
      UPDATE lighthouse_sample AS lsample
      SET lsample.is_current=0, lsample.current_rna_id=NULL;
    )
  end
end
