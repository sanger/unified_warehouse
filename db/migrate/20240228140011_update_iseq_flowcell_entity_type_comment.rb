class UpdateIseqFlowcellEntityTypeComment < ActiveRecord::Migration[7.0]
  def up
    change_column_comment :iseq_flowcell, :entity_type, "Lane type: library, library_control, library_indexed, library_indexed_spike"
  end

  def down
    change_column_comment :iseq_flowcell, :entity_type, "Lane type: library, pool, library_control, library_indexed, library_indexed_spike"
  end
end
