class UpdateTableColumnComment < ActiveRecord::Migration[7.0]
  def up
    change_column_comment :aliquot, :id_aliquot_lims,
                          'The ID of the aliquot in the LIMS system'
  end
end
