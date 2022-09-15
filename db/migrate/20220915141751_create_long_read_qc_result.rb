# frozen_string_literal: true

# Added a new table long_read_qc_result to be able to query QC data from the extraction process
class CreateLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    create_table :long_read_qc_result do |t|
      t.string :labware_barcode, null: false
      t.string :sample_id, null: false
      t.string :assay_type, null: false
      t.string :assay_type_key, null: false
      t.string :units
      t.string :value, null: false
      t.string :id_lims
      t.string :id_long_read_qc_result_lims
      t.datetime :created
      t.datetime :last_updated
      t.datetime :recorded_at
    end
  end
end
