class PipelineIdCanBeNull < ActiveRecord::Migration
  def up
    change_column :iseq_flowcell, :pipeline_id_lims, :string, limit: 30, null: true, default: nil
  end

  def down
    change_column :iseq_flowcell, :pipeline_id_lims, :string, limit: 30, null: false, default: nil
  end
end
