# frozen_string_literal: true

# This migration removes the separate index on id_flowcell_lims column,
# assuming that the composite unique index which already includes the column
# is enough to support the queries that need to be performed.
class RemoveIndexEseqFlowcellIdFlowcellLims < ActiveRecord::Migration[7.2]
  INDEX_NAME = 'index_eseq_flowcell_on_id_flowcell_lims'
  def up
    remove_index :eseq_flowcell, name: INDEX_NAME, if_exists: true
  end
  def down
    add_index :eseq_flowcell, :id_flowcell_lims, name: INDEX_NAME
  end
end
