# frozen_string_literal: true

class RemoveIndexEseqFlowcellIdLims < ActiveRecord::Migration[7.1]
  def up
    remove_index :eseq_flowcell, name: 'id_lims', if_exists: true
  end

  def down
    add_index :eseq_flowcell, :id_lims, name: 'id_lims'
  end
end
