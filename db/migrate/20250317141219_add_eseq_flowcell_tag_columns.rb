# This migration adds entity_id_lims, is_spiked and tag related columns to the
# existing eseq_flowcell table to make it similar to the iseq_flowcell table.
class AddEseqFlowcellTagColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :eseq_flowcell, :entity_id_lims, :string, limit: 20, null: false, comment: 'Most specific LIMs identifier associated with this lane or plex or spike'
    # sequencecape aliquot_index is mapped to tag_index
    add_column :eseq_flowcell, :tag_index, 'smallint unsigned', null: true, comment: 'Tag index, NULL if lane is not a pool'
    add_column :eseq_flowcell, :tag_set_id_lims, :string, limit: 20, null: true, comment: 'LIMs-specific identifier of the tag set'
    add_column :eseq_flowcell, :tag_set_name, :string, limit: 100, null: true, comment: 'WTSI-wide tag set name'
    add_column :eseq_flowcell, :tag_identifier, :string, limit: 30, null: true, comment: 'The position of tag within the tag group'
    add_column :eseq_flowcell, :tag2_set_id_lims, :string, limit: 20, null: true, comment: 'LIMs-specific identifier of the tag set for tag 2'
    add_column :eseq_flowcell, :tag2_set_name, :string, limit: 100, null: true, comment: 'WTSI-wide tag set name for tag 2'
    add_column :eseq_flowcell, :tag2_identifier, :string, limit: 30, null: true, comment: 'The position of tag2 within the tag group'
    add_column :eseq_flowcell, :is_spiked, :boolean, null: false, default: false, comment: 'Boolean flag indicating presence of a spike'
  end
end
