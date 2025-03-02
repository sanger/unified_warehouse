class CreateEseqFlowcell < ActiveRecord::Migration[7.0]
  def change
    create_table :eseq_flowcell, options: 'CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
      t.string :run_name, limit: 80, null: false, comment: 'Run name as given to the instrument'
      t.datetime :last_updated, null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at, null: false, comment: 'Timestamp of warehouse update'
      t.integer :id_sample_tmp, 'integer unsigned', null: false, comment: 'Sample id, see "sample.id_sample_tmp"'
      t.integer :id_study_tmp, 'integer unsigned', null: true, comment: 'Study id, see "study.id_study_tmp"'
      t.string :id_lims, limit: 10, null: false, comment: 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE'
      t.smallint :lane, 'smallint unsigned', null: false, comment: 'Flowcell lane number, 1 or 2'
      t.string :entity_type, limit: 30, null: false, comment: 'Library type: library_indexed, library_indexed_spike'
      t.string :tag_sequence, limit: 30, null: true, comment: 'Tag sequence'
      t.string :tag2_sequence, limit: 30, null: true, comment: 'Tag sequence for tag 2'
      t.string :pipeline_id_lims, limit: 60, null: true, comment: 'LIMs-specific pipeline identifier that unambiguously defines library type'
      t.string :bait_name, limit: 50, null: true, comment: 'WTSI-wide name that uniquely identifies a bait set'
      t.integer :requested_insert_size_from, 'integer unsigned', null: true, comment: 'Requested insert size min value'
      t.integer :requested_insert_size_to, 'integer unsigned', null: true, comment: 'Requested insert size max value'
      t.string :id_pool_lims, limit: 20, null: false, comment: 'Most specific LIMs identifier associated with the pool'
      t.string :id_library_lims, limit: 255, null: true, comment: 'Earliest LIMs identifier associated with library creation'
      t.string :primer_panel, limit: 255, null: true, comment: 'Primer Panel name'
    end
  end
end
