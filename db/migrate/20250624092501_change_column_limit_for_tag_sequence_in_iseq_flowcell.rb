class ChangeColumnLimitForTagSequenceInIseqFlowcell < ActiveRecord::Migration[7.2]
  def change
    change_column :iseq_flowcell, :tag_sequence, :string, limit: 50
    change_column :iseq_flowcell, :tag2_sequence, :string, limit: 50
  end
end
