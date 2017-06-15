class AddSuboptimalFlagToIseqFlowcellTable < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.boolean   'suboptimal', comment: 'Indicates that a sample has failed a QC step during processing'
    end
  end
end
