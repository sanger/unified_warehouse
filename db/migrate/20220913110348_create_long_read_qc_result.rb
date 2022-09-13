# frozen_string_literal: true

# Created long_read_qc_result table to query QC data from the extraction process
class CreateLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    create_table :long_read_qc_result do |t|
      t.string :labware_barcode, null: false
      t.string :sample_id, null: false
      t.string :assay_type, null: false
      t.string :key, null: false
      t.string :units
      t.string :value, null: false

      t.timestamps
    end
  end
end
