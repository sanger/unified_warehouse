# frozen_string_literal: true

# Added a new table labware_location
class CreateLabwareLocation < ActiveRecord::Migration[7.0]
  def change
    create_table :labware_location do |t|
      t.string :item_barcode, unique: true, comment: 'Barcode on the stored labware'
      t.string :location_barcode, comment: 'Barcode associated with storage location'
      t.string :full_location_address, comment: 'Fully qualifed address of the nested location'
      t.integer :coord_position, null: true, comment: 'Position'
      t.integer :coord_row, null: true, comment: 'Row'
      t.integer :coord_column, null: true, comment: 'Column'
      t.string :lims_id, comment: 'ID of the storage system this data comes from'
      t.string :stored_by, comment: 'Username of the person who placed the item there'
      t.datetime :stored_at, comment: 'Datetime the item was stored at this location'

      t.timestamps

      t.index :location_barcode
      t.index :full_location_address
    end
  end
end
