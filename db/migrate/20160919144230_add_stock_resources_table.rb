class AddStockResourcesTable < ActiveRecord::Migration
  def change
    # Using singluar table names to maintain convention with rest of warehouse
    create_table :stock_resource, primary_key: :id_stock_resource_tmp do |t|
      t.datetime :last_updated,               null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at,                null: false, comment: 'Timestamp of warehouse update'
      t.datetime :created,                    null: false, comment: 'Timestamp of initial registration of stock in LIMS'
      t.datetime :deleted_at,                 null: true,  comment: 'Timestamp of initial registration of deletion in parent LIMS. NULL if not deleted.'

      t.column :id_sample_tmp,   'integer unsigned',   null: false, comment: 'Sample id, see "sample.id_sample_tmp"'
      t.column :id_study_tmp,    'integer unsigned',   null: false, comment: 'Sample id, see "study.id_study_tmp"'
      t.string :id_lims, limit: 10, null: false, comment: 'LIM system identifier'

      t.string :id_stock_resource_lims, limit: 20, null: false, comment: 'Lims specific identifier for the stock'
      t.string :stock_resource_uuid, limit: 36, comment: 'Uuid identifier for the stock'

      t.string :labware_type,            null: false, comment: 'The type of labware containing the stock. eg. Well, Tube'

      t.string :labware_machine_barcode, null: false, comment: 'The barcode of the containing labware as read by a barcode scanner'
      t.string :labware_human_barcode,   null: false, comment: 'The barcode of the containing labware in human readable format'
      t.string :labware_coordinate,      null: true,  comment: 'For wells, the coordinate on the containing plate. Null for tubes.'

      t.float :current_volume,           null: true, comment: 'The current volume of material in microlitres based on measurements and know usage'
      t.float :initial_volume,           null: true, comment: 'The result of the initial volume measurement in microlitres conducted on the material'
      t.float :concentration,            null: true, comment: 'The concentration of material recorded in the lab in nanograms per microlitre'

      t.string :gel_pass,                null: true, comment: 'The recorded result for the qel QC assay.'
      t.string :pico_pass,               null: true, comment: 'The recorded result for the pico green assay. A pass indicates a successful assay, not sufficient material.'
      t.integer :snp_count,              null: true, comment: 'The number of markers detected in genotyping assays'
      t.string :measured_gender,         null: true, comment: 'The gender call base on the genotyping assay'
    end
  end
end
