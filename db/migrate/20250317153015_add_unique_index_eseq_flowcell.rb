# frozen_string_literal: true

# Adds a multicolumn unique index to the eseq_flowcell table.
class AddUniqueIndexEseqFlowcell < ActiveRecord::Migration[7.1]
  def change
    add_index :eseq_flowcell, %i[
      id_flowcell_lims
      lane
      tag_sequence
      tag2_sequence
    ], unique: true, name: 'index_eseq_flowcell_composition_keys'
  end
end
