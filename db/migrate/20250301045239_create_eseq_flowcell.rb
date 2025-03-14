class CreateEseqFlowcell < ActiveRecord::Migration[7.0]
  def change
    create_table :eseq_flowcell, id: false, options: 'CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
      t.column :id_eseq_flowcell_tmp, 'integer unsigned auto_increment', primary_key: true, comment: 'Internal to this database, id value can change'
      t.string :id_flowcell_lims, limit: 255, null: false, comment: 'LIMs-specific flowcell id, batch_id for Sequencescape', index: true
      t.string :run_name, limit: 80, null: false, comment: 'Run name as given to the instrument'
      t.datetime :last_updated, null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at, null: false, comment: 'Timestamp of warehouse update'
      t.column :id_sample_tmp, 'integer unsigned', null: false, comment: 'Sample id, see "sample.id_sample_tmp"'
      t.column :id_study_tmp, 'integer unsigned', null: false, comment: 'Study id, see "study.id_study_tmp"'
      t.string :id_lims, limit: 10, null: false, comment: 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE', index: true
      t.column :lane, 'smallint unsigned', null: false, comment: 'Flowcell lane number, 1 or 2'
      t.string :entity_type, limit: 30, null: false, comment: 'Library type: library_indexed, library_indexed_spike'
      t.string :tag_sequence, limit: 30, null: true, comment: 'Tag sequence'
      t.string :tag2_sequence, limit: 30, null: true, comment: 'Tag sequence for tag 2'
      t.string :pipeline_id_lims, limit: 60, null: true, comment: 'LIMs-specific pipeline identifier that unambiguously defines library type'
      t.string :bait_name, limit: 50, null: true, comment: 'WTSI-wide name that uniquely identifies a bait set'
      t.column :requested_insert_size_from, 'integer unsigned', null: true, comment: 'Requested insert size min value'
      t.column :requested_insert_size_to, 'integer unsigned', null: true, comment: 'Requested insert size max value'
      t.string :id_pool_lims, limit: 20, null: false, comment: 'Most specific LIMs identifier associated with the pool', index: true
      t.string :id_library_lims, limit: 255, null: true, comment: 'Earliest LIMs identifier associated with library creation', index: true
      t.string :primer_panel, limit: 255, null: true, comment: 'Primer Panel name'

    end

    add_foreign_key :eseq_flowcell, :sample, column: :id_sample_tmp, primary_key: :id_sample_tmp, name: 'eseq_flowcell_sample_fk'
    add_foreign_key :eseq_flowcell, :study, column: :id_study_tmp, primary_key: :id_study_tmp, name: 'eseq_flowcell_study_fk'
  end
end
