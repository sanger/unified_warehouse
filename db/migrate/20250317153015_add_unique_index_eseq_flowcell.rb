# frozen_string_literal: true

# Adds a multicolumn unique index to the eseq_flowcell table.
class AddUniqueIndexEseqFlowcell < ActiveRecord::Migration[7.1]
  # Max length of the index name is 64 characters.
  # The composition keys are used to identify the rows in the nested sections
  # of the flowcell JSON data. The index is unique on these keys.
  INDEX_NAME = 'index_eseq_flowcell_on_composition_keys'
  def up
    add_index :eseq_flowcell, %i[
      id_flowcell_lims
      lane
      tag_sequence
      tag2_sequence
      id_lims
    ], unique: true, name: INDEX_NAME
  end
  def down
    remove_index :eseq_flowcell, name: INDEX_NAME
  end
end
