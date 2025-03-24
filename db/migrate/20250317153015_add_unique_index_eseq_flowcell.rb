# frozen_string_literal: true

# Adds a multicolumn unique index to the eseq_flowcell table.
class AddUniqueIndexEseqFlowcell < ActiveRecord::Migration[7.1]
  def change
    add_index :eseq_flowcell, %i[
      tag_index
      id_flowcell_lims
      entity_id_lims
      entity_type
      lane
      tag_sequence
      tag2_sequence
    ], unique: true, name: 'index_eseq_flowcell_composition_keys'
  end
end
