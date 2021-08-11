# frozen_string_literal: true

# Add indexes for lighthouse samples to assist in ETL failures where
# the database statements are taking too long to run.
class AddIndexesOnLighthouseSamples < ActiveRecord::Migration[6.0]
  def up
    change_table :lighthouse_sample, bulk: true do |t|
      t.index :rna_id
      t.index %i[plate_barcode created_at]
    end
  end

  def down
    change_table :lighthouse_sample, bulk: true do |t|
      t.remove_index :rna_id
      t.remove_index %i[plate_barcode created_at]
    end
  end
end
