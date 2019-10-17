# frozen_string_literal: true

class AddBmapFlowcellTable < ActiveRecord::Migration
  def change
    # rubocop:disable Rails/CreateTableWithTimestamps
    create_table :bmap_flowcell, primary_key: :id_bmap_flowcell_tmp do |t|
      t.datetime :last_updated,               null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at,                null: false, comment: 'Timestamp of warehouse update'
      t.column :id_sample_tmp,   'integer unsigned',   null: false, comment: 'Sample id, see "sample.id_sample_tmp"'
      t.column :id_study_tmp,    'integer unsigned',   null: false, comment: 'Study id, see "study.id_study_tmp"'
      t.string :experiment_name, null: false, comment: 'The name of the experiment, eg. The lims generated run id'
      t.string :instrument_name, null: false, comment: 'The name of the instrument on which the sample was run'
      t.string :enzyme_name, null: false, comment: 'The name of the recognition enzyme used'
      t.string :chip_barcode, null: false, comment: 'Manufacturer chip identifier'
      t.string :chip_serialnumber, limit: 16, comment: 'Manufacturer chip identifier'
      t.column :position, 'integer unsigned', limit: 2, comment: 'Flowcell position'
      t.string :id_flowcell_lims, null: false, comment: 'LIMs-specific flowcell id', index: true
      t.string :id_library_lims, comment: 'Earliest LIMs identifier associated with library creation', index: true
      t.string :id_lims, limit: 10, null: false, comment: 'LIM system identifier'
    end
    # rubocop:enable Rails/CreateTableWithTimestamps

    add_foreign_key :bmap_flowcell, :sample, column: :id_sample_tmp, primary_key: :id_sample_tmp, name: 'fk_bmap_flowcell_to_sample'
    add_foreign_key :bmap_flowcell, :study, column: :id_study_tmp, primary_key: :id_study_tmp, name: 'fk_bmap_flowcell_to_study'
  end
end
