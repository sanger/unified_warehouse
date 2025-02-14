class AddRebascallingProcessToOseqFlowcell < ActiveRecord::Migration[7.0]
  def change
    add_column :oseq_flowcell, :rebascalling_process, :string, limit: 50
  end
end
