class AddPacBioTable < ActiveRecord::Migration

  def change
    create_table :pac_bio_run, primary_key: :id_pac_bio_tmp do |t|

      t.datetime :last_updated,               null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at,                null: false, comment: 'Timestamp of warehouse update'

      t.column :id_sample_tmp,   'integer unsigned',   null: false, comment: 'Sample id, see "sample.id_sample_tmp"'
      t.column :id_study_tmp,    'integer unsigned',   null: false, comment: 'Sample id, see "study.id_study_tmp"'

      t.string :id_pac_bio_run_lims, limit: 20, null: false, comment: 'Lims specific identifier for the pacbio run'
      t.string :pac_bio_run_uuid,    limit: 36,              comment: 'Uuid identifier for the pacbio run'

      t.string :cost_code,        limit: 20,  null:false, comment: 'Valid WTSI cost-code'
      t.string :id_lims,          limit:10,   null:false, comment: 'LIM system identifier'

      t.string :tag_identifier,   limit: 30,              comment: 'Tag index within tag set, NULL if untagged'
      t.string :tag_sequence,     limit: 30,              comment: 'Tag sequence for tag'
      t.string :tag_set_id_lims,  limit: 20,              comment: 'LIMs-specific identifier of the tag set for tag'
      t.string :tag_set_name,     limit: 100,             comment: 'WTSI-wide tag set name for tag'

      t.string :plate_barcode,                null:false, comment: 'The human readable barcode for the plate loaded onto the machine'
      t.string :plate_uuid_lims,  limit: 36,  null:false, comment: 'The plate uuid'

      t.string :well_label,                    null:false, comment: 'The well identifier for the plate, A1-H12'
      t.string :well_uuid_lims,   limit: 36,   null:false, comment: 'The well uuid'

      t.string :pac_bio_library_tube_id_lims,   null:false, comment: 'LIMS specific identifier for originating library tube'
      t.string :pac_bio_library_tube_uuid,      null:false, comment: 'The uuid for the originating library tube'
      t.string :pac_bio_library_tube_name,      null:false, comment: 'The name of the originating library tube'

      t.integer :pac_bio_library_tube_legacy_id,            comment: 'Legacy library_id for backwards compatibility.'
    end
  end
end

