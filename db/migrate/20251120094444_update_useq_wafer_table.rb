class UpdateUseqWaferTable < ActiveRecord::Migration[7.2]
  def up
    # Update character set and collation to utf8mb3
    execute <<-SQL
      ALTER TABLE useq_wafer CONVERT TO CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci;
    SQL

    # Rename id_wafer_lims to batch_for_opentrons, representative of its purpose
    rename_column :useq_wafer, :id_wafer_lims, :batch_for_opentrons
    change_column_comment :useq_wafer, :batch_for_opentrons, "A Sequencescape LIMS-specific batch_id that represents the (pair of) pools processed on the Opentrons"

    # Update the primary key column to be int unsigned and add a comment
    execute <<-SQL
      ALTER TABLE useq_wafer
      MODIFY COLUMN id_useq_wafer_tmp integer unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database, id value can change';
    SQL
  
    # Remove lane column
    remove_column :useq_wafer, :lane
  end

  def down
    # Revert batch_for_opentrons back to id_wafer_lims
    rename_column :useq_wafer, :batch_for_opentrons, :id_wafer_lims
    change_column_comment :useq_wafer, :id_wafer_lims, "LIMs-specific wafer id, batch_id for Sequencescape"

    # Revert the primary key column back to bigint
    execute <<-SQL
      ALTER TABLE useq_wafer
      MODIFY COLUMN id_useq_wafer_tmp bigint NOT NULL AUTO_INCREMENT;
    SQL

    # Re-add lane column
    add_column :useq_wafer, :lane, :integer, limit: 2, null: false, comment: "Wafer lane number", unsigned: true
    
    # Recreate the unique index on composition keys with lane included
    remove_index :useq_wafer, name: 'index_useq_wafer_on_composition_keys'
    add_index :useq_wafer, %i[
      id_wafer_lims
      lane
      tag_sequence
      id_lims
    ], unique: true, name: 'index_useq_wafer_on_composition_keys'
  end
end
