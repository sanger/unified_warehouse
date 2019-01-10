class ExtendIseqFlowcellTable < ActiveRecord::Migration
  def change
    add_column :iseq_flowcell, :spiked_phix_barcode, :string, limit: 20, comment: 'Barcode of the PhiX tube added to the lane'
    add_column :iseq_flowcell, :spiked_phix_percentage, :float, comment: 'Percentage PhiX tube spiked in the pool in terms of molar concentration'
    add_column :iseq_flowcell, :loading_concentration, :float, comment: 'Final instrument loading concentration (pM)'
    add_column :iseq_flowcell, :workflow, :string, limit: 20, comment: 'Workflow used when processing the flowcell'
  end
end
