class UpdateFlgenPlateTable < ActiveRecord::Migration
  def up
    change_table :flgen_plate do |t|
      t.change 'plate_barcode_lims', :string, limit: 128, null: true, comment: 'LIMs-specific plate barcode'
    end
  end
end
