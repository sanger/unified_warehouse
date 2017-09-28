class AddTeamColumnToIseqFlowcell < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.string 'team', comment: 'The team responsible for creating the flowcell'
    end
  end
end
