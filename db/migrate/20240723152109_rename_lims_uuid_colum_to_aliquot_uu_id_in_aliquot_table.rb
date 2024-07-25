class RenameLimsUuidColumToAliquotUuIdInAliquotTable < ActiveRecord::Migration[7.0]
  def up
    rename_column :aliquot, :lims_uuid, :aliquot_uuid
  end

  def down
    rename_column :aliquot, :aliquot_uuid, :lims_uuid
  end
end
