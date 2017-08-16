class AddOseqFlowcellTable < ActiveRecord::Migration
  def change
    create_table :oseq_flowcell, primary_key: :id_oseq_flowcell_tmp, options: 'CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
      t.datetime :last_updated,               null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at,                null: false, comment: 'Timestamp of warehouse update'

      t.column :id_sample_tmp,   'integer unsigned',   null: false, comment: 'Sample id, see "sample.id_sample_tmp"'
      t.column :id_study_tmp,    'integer unsigned',   null: false, comment: 'Study id, see "study.id_study_tmp"'

      # Set to string for the moment, until we know more
      t.string :experiment_name, null: false, comment: 'The name of the experiment'
      t.string :instrument_name, null: false, comment: 'The name of the instrument on which the sample was run'
      t.integer :instrument_slot, null: false, comment: 'The numeric identifier of the slot on which the sample was run'

      # This is library type in Sequencescape. Named for compatibility with iseq_flowcell table
      t.string :pipeline_id_lims, null: false, comment: 'LIMs-specific pipeline identifier that unambiguously defines library type'
      t.string :requested_data_type, null: false, comment: 'The type of data produces by sequencing, eg. basecalls only'

      t.string :id_lims,          limit:10,   null:false, comment: 'LIM system identifier'
    end
  end
end
