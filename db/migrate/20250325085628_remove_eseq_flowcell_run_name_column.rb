class RemoveEseqFlowcellRunNameColumn < ActiveRecord::Migration[7.2]
  def up
    remove_column :eseq_flowcell, :run_name
  end
  def down
    add_column :eseq_flowcell, :run_name, :string, limit: 80, null: false,
                comment: 'Run name as given to the instrument'
  end
end
