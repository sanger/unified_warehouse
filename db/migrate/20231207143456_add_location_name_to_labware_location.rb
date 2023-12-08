class AddLocationNameToLabwareLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :labware_location, :location_name, :string, null: false, comment: 'Name of location where labware is stored', after: :full_location_address
  end
end
