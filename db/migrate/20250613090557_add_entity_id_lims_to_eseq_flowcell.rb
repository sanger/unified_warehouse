# `entity_id_lims` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL COMMENT 'Most specific LIMs identifier associated with this lane or plex or spike',
class AddEntityIdLimsToEseqFlowcell < ActiveRecord::Migration[7.2]
  def up
    # Add the column without the 'not null' constraint first.
    add_column :eseq_flowcell, :entity_id_lims, :string, limit: 20, null: true, comment: 'Most specific LIMs identifier associated with this lane or plex or spike'

    # Update the existing records to set the column to 'unknown'.
    EseqFlowcell.where(entity_id_lims: nil).update_all(entity_id_lims: 'unknown')

    # Add the 'not null' constraint after updating existing records
    change_column_null :eseq_flowcell, :entity_id_lims, false
  end

  def down
    # Remove the column if rolling back the migration.
    remove_column :eseq_flowcell, :entity_id_lims
  end
end
