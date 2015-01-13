class DropIseqFlowcellNumTargetComponents < ActiveRecord::Migration
  def change
    # The down migration will not restore a column with exactly the same parameters
    # as before. Type will be smallint(6) not smallint(4)
    # I am instead choosing to favour Rails convention, over the dictated schema
    remove_column  :iseq_flowcell, 'num_target_components', :integer,
      limit: 2,
      null: false,
      comment: 'Expected number of targets, one for a non-pool and number of target tags for a pool'
  end
end
