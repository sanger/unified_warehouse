class AddUniqueKeyToIseqFlowcell < ActiveRecord::Migration[7.2]
  def change
    add_index :iseq_flowcell, [:id_flowcell_lims, :position, :tag_index], unique: true, name: 'unique_flowcell_position_tag'
  end
end
