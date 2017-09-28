class AddPurposeColumnToIseqFlowcellTable < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.string   'purpose', limit: 30, comment: 'Describes the reason the sequencing was conducted. Eg. Standard, QC, Control'
    end
  end
end
