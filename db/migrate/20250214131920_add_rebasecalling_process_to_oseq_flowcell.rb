class AddRebasecallingProcessToOseqFlowcell < ActiveRecord::Migration[7.0]
  def change
    add_column :oseq_flowcell, :rebasecalling_process, :string, limit: 50
  end
end
