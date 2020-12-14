class AddQcResultTable < ActiveRecord::Migration
  def change
    create_table :qc_result, primary_key: :id_qc_result_tmp do |t|
      t.column :id_sample_tmp, 'integer unsigned', null: false
      t.string :id_qc_result_lims, limit: 20, null: false, comment: 'LIMS-specific qc_result identifier'
      t.string :id_lims, limit: 10, null: false, comment: 'LIMS system identifier (e.g. SEQUENCESCAPE)'
      t.string :id_pool_lims,          comment: 'Most specific LIMs identifier associated with the pool. (Asset external_identifier in SS)'
      t.string :id_library_lims,       comment: 'Earliest LIMs identifier associated with library creation. (Aliquot external_identifier in SS)'
      t.string :labware_purpose,       comment: 'Labware Purpose name. (e.g. Plate Purpose for a Well)'
      t.string :assay,                 comment: 'assay type and version'
      t.string :value,    null: false, comment: 'Value of the mesurement'
      t.string :units,    null: false, comment: 'Mesurement unit'
      t.float  :cv, comment: 'Coefficient of variance'
      t.string :qc_type, null: false, comment: 'Type of mesurement'
      t.datetime :date_created, null: false, comment: 'The date the qc_result was first created in SS'
      t.datetime :date_updated, null: false, comment: 'The date the qc_result was last updated in SS'
      t.datetime :recorded_at,  null: false, comment: 'Timestamp of warehouse update'
    end
  end
end
