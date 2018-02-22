class AddPrimerPanelToIseqFlowcell < ActiveRecord::Migration
  def change
    add_column :iseq_flowcell, :primer_panel, :string
  end
end
