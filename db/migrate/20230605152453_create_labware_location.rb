# frozen_string_literal: true

# Added a new table labware_location
class CreateLabwareLocation < ActiveRecord::Migration[7.0]
  def change
    create_table :labware_location do |t|
      t.string :labware_barcode, null: false, comment: 'Barcode on the stored labware'
      t.string :location_barcode, null: false, comment: 'Barcode associated with storage location'
      t.string :full_location_address, null: false, comment: 'Fully qualifed address of the nested location'
      t.integer :coordinate_position, null: true, comment: 'Coordinate position of labware in storage location'
      t.integer :coordinate_row, null: true, comment: 'Coordinate row of labware in storage location'
      t.integer :coordinate_column, null: true, comment: 'Coordinate column of labware in storage location'
      t.string :lims_id, null: false, comment: 'ID of the storage system this data comes from'
      t.string :stored_by, null: false, comment: 'Username of the person who placed the item there'
      t.datetime :stored_at, null: false, comment: 'Datetime the item was stored at this location'

      t.timestamps

      t.index :labware_barcode, unique: true
      t.index :location_barcode
    end
  end
end
