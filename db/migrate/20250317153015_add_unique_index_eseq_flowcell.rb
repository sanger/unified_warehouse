# frozen_string_literal: true

# This migration adds a multicolumn unique index to the eseq_flowcell table.
class AddUniqueIndexEseqFlowcell < ActiveRecord::Migration[7.1]
  def change
    add_index :eseq_flowcell, %i[id_flowcell_lims lane tag_index id_lims], unique: true, name: 'index_eseq_flowcell_id_flowcell_lims_position_tag_index_id_lims'
  end
end
