class RenameAliquotTableColumn < ActiveRecord::Migration[7.0]
  def up
    rename_column :aliquot, :lims_uuid, :id_aliquot_lims
  end

  def down
    rename_column :aliquot, :id_aliquot_lims, :lims_uuid
  end
end
