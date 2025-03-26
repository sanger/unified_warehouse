# frozen_string_literal: true

# This migration removes the index on the id_lims column from the initial
# eseq_flowcell table because it is coarse and inefficient.
class RemoveIndexEseqFlowcellIdLims < ActiveRecord::Migration[7.1]
  INDEX_NAME = 'index_eseq_flowcell_on_id_lims'
  def up
    remove_index :eseq_flowcell, name: INDEX_NAME, if_exists: true
  end

  def down
    add_index :eseq_flowcell, :id_lims, name: INDEX_NAME
  end
end
