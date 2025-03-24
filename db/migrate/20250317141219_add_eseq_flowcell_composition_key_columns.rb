# frozen_string_literal: true

# This migration adds entity_id_lims and tag_index to the existing eseq_flowcell
# table to make the record handling similar to the iseq_flowcell table.
class AddEseqFlowcellCompositionKeyColumns < ActiveRecord::Migration[7.1]
  def change
    # sequencecape aliquot_index is mapped to tag_index
    add_column :eseq_flowcell, :tag_index, 'smallint unsigned', null: true,
               comment: 'Tag index, NULL if lane is not a pool'
    add_column :eseq_flowcell, :entity_id_lims, :string, limit: 255, null: true,
               comment: 'Most specific LIMs identifier associated with this ' \
                        'lane or plex or spike'
  end
end
