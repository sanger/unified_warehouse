class AddIdLongReadQcResultLimsToLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    add_column :long_read_qc_result, :id_long_read_qc_result_lims, :string
  end
end
