class AddIndexToStockResources < ActiveRecord::Migration
  def change
    add_index :stock_resource, %i[id_stock_resource_lims id_sample_tmp id_lims], name: :composition_lookup_index
  end
end
