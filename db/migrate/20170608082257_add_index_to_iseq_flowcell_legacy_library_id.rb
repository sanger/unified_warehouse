class AddIndexToIseqFlowcellLegacyLibraryId < ActiveRecord::Migration
  def change
    ActiveRecord::Base.transaction do
      add_index :iseq_flowcell, :legacy_library_id, name: :index_iseq_flowcell_legacy_library_id
    end
  end
end
