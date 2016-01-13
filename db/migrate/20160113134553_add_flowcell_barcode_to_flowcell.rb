class AddFlowcellBarcodeToFlowcell < ActiveRecord::Migration
  def change
    add_index :iseq_flowcell, :flowcell_barcode
  end
end
