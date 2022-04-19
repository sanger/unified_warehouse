# frozen_string_literal: true

# Alter existing non-null constraints for pipeline_id_lims and requested_data_type columns
# Add columns for sample tags
# Added for the Heron project
class UpdateOseqFlowcellFields < ActiveRecord::Migration
  # Disable the cop as realistically we're never going to update historical migrations
  def change
    change_table :oseq_flowcell, bulk: true do
      # Remove non-null constraints from columns
      change_column :oseq_flowcell, :pipeline_id_lims, :string, null: true, comment: 'LIMs-specific pipeline identifier that unambiguously defines library type'
      change_column :oseq_flowcell, :requested_data_type, :string, null: true, comment: 'The type of data produced by sequencing, eg. basecalls only'

      # Add columns for sample tags
      add_column :oseq_flowcell, :tag_identifier, :string, null: true, comment: 'Position of the first tag within the tag group'
      add_column :oseq_flowcell, :tag_sequence, :string, null: true, comment: 'Sequence of the first tag'
      add_column :oseq_flowcell, :tag_set_id_lims, :string, null: true, comment: 'LIMs-specific identifier of the tag set for the first tag'
      add_column :oseq_flowcell, :tag_set_name, :string, null: true, comment: 'WTSI-wide tag set name for the first tag'
      add_column :oseq_flowcell, :tag2_identifier, :string, null: true, comment: 'Position of the second tag within the tag group'
      add_column :oseq_flowcell, :tag2_sequence, :string, null: true, comment: 'Sequence of the second tag'
      add_column :oseq_flowcell, :tag2_set_id_lims, :string, null: true, comment: 'LIMs-specific identifier of the tag set for the second tag'
      add_column :oseq_flowcell, :tag2_set_name, :string, null: true, comment: 'WTSI-wide tag set name for the second tag'
    end
  end
end
