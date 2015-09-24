class AddIdLibraryLimsIsPoolLimsIndices < ActiveRecord::Migration
  def change
    add_index :iseq_flowcell, :id_pool_lims
    add_index :iseq_flowcell, :id_library_lims
  end
end
