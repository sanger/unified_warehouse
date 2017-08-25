# The initial scheme was generated externally from rails, so doesn't follow
# some standard conventions. We change the primary key to match that used
# elsewhere
class ChangeOseqFlowecellPkForConsistency < ActiveRecord::Migration
  def up
    change_column :oseq_flowcell, :id_oseq_flowcell_tmp, 'int(10) unsigned AUTO_INCREMENT'
  end

  def down
    change_column :oseq_flowcell, :id_oseq_flowcell_tmp, :integer
  end
end
