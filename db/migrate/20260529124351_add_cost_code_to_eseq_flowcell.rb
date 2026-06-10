class AddCostCodeToEseqFlowcell < ActiveRecord::Migration[7.2]
  def change
    add_column :eseq_flowcell, :cost_code, :string, limit: 20, comment: "Valid WTSI cost code"
  end
end
