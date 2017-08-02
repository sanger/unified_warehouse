class AddSearchIndexesToIseqFlowcell < ActiveRecord::Migration
  def change
    ActiveRecord::Base.transaction do
      add_index :iseq_flowcell, [:id_flowcell_lims, :position, :tag_index], :name => :index_iseqflowcell__id_flowcell_lims__position__tag_index
      add_index :iseq_flowcell, [:flowcell_barcode, :position, :tag_index], :name => :index_iseqflowcell__flowcell_barcode__position__tag_index
    end
  end
end
