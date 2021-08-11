# frozen_string_literal: true

# Add indexes for lighthouse samples to assist in ETL failures where
# the database statements are taking too long to run.
class AddIndexesOnLighthouseSamples < ActiveRecord::Migration[6.0]
  def up
    add_index :lighthouse_sample, :rna_id
    add_index :lighthouse_sample, [:plate_barcode, :created_at]
  end

  def down
    remove_index :lighthouse_sample, :rna_id
    remove_index :lighthouse_sample, [:plate_barcode, :created_at]
  end
end
