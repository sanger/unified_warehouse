class UpdateIseqFlowcellEntityTypeComment < ActiveRecord::Migration[7.0]
  def change
    change_column_comment :iseq_flowcell, :entity_type, "Lane type: library, library_control, library_indexed, library_indexed_spike."
  end
end
