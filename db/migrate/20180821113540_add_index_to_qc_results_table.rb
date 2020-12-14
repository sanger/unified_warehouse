class AddIndexToQcResultsTable < ActiveRecord::Migration
  def change
    add_index :qc_result, %i[id_qc_result_lims id_lims], name: :lookup_index
  end
end
