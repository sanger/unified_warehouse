class CreateAliquots < ActiveRecord::Migration[7.0]
  def up
    create_table :aliquot, primary_key: :id, options: 'CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
      t.string :id_lims, null: false, comment: 'The LIMS system that the aliquot was created in'
      t.string :lims_uuid, null: false, comment: 'The UUID of the aliquot in the LIMS system'
      t.string :aliquot_type, null: false, comment: 'The type of the aliquot'
      t.string :source_type, null: false, comment: 'The type of the source of the aliquot'
      t.string :source_barcode, null: false, comment: 'The barcode of the source of the aliquot'
      t.string :sample_name, null: false, comment: 'The name of the sample that the aliquot was created from'
      t.string :used_by_type, null: false, comment: 'The type of the entity that the aliquot is used by'
      t.string :used_by_barcode, null: false, comment: 'The barcode of the entity that the aliquot is used by'
      t.decimal :volume, precision: 10, scale: 2, null: false, comment: 'The volume of the aliquot'
      t.decimal :concentration, precision: 10, scale: 2, null: false, comment: 'The concentration of the aliquot'
      t.datetime :last_updated,               null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at,                null: false, comment: 'Timestamp of warehouse update'
      t.datetime :created_at,                    null: false, comment: 'Timestamp of initial registration of stock in LIMS'
    end
  end

  def down
    drop_table :aliquot
  end
end
