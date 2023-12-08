# frozen_string_literal: true

# New column for name of location where plates are stored
class AddLocationNameToLabwareLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :labware_location, :location_name, :string, null: false, default: '', comment: 'Name of location where labware is stored', after: :full_location_address
  end
end
