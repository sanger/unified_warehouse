class CreateCgapHeron < ActiveRecord::Migration
  def change
    create_table :cgap_heron, options: 'CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
      t.string :tube_rack_barcode, null: false
      t.string :tube_barcode, null: false
      t.string :supplier_sample_id, index: true, null: false
      t.string :position, null: false

      t.index :tube_barcode, unique: true
      t.index [:tube_rack_barcode, :position], unique: true
    end
  end
end
