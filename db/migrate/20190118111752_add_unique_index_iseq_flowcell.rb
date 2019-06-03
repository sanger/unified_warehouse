# frozen_string_literal: true

class AddUniqueIndexIseqFlowcell < ActiveRecord::Migration
  def change
    add_index :iseq_flowcell, [:id_flowcell_lims, :position, :tag_index, :id_lims], unique: true, name: 'index_iseq_flowcell_id_flowcell_lims_position_tag_index_id_lims'
  end
end
