# frozen_string_literal: true

# Added a new table long_read_qc_result to be able to query QC data from the extraction process
class CreateLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    create_table :long_read_qc_result, primary_key: :id_long_read_qc_result_tmp do |t|
      t.string :labware_barcode, null: false, comment: 'Barcode of the labware that was the source for the QC tests.'
      t.string :sample_id, null: false, comment: 'External identifier for the sample(s).'
      t.string :assay_type, null: false, comment: 'Type of the QC test.'
      t.string :assay_type_key, null: false, comment: 'Unique identifier of the QC test.'
      t.string :units, comment: 'Unit of the value for example mg,ng etc'
      t.string :value, null: false, comment: 'QC result value'
      t.string :id_lims, comment: 'Identifier of the LIMS where QC was published from'
      t.string :id_long_read_qc_result_lims, comment: 'LIMS specific id for QC result'
      t.datetime :created, comment: 'The date the qc_result was first created in LIMS'
      t.datetime :last_updated, comment: 'The date the qc_result was last updated in LIMS.'
      t.datetime :recorded_at, comment: 'Timestamp of the latest warehouse update.'
    end
  end
end
