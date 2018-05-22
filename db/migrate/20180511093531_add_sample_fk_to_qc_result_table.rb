class AddSampleFkToQcResultTable < ActiveRecord::Migration
  def change
    add_foreign_key :qc_result, :sample, column: :id_sample_tmp, primary_key: :id_sample_tmp, name: 'fk_qc_result_to_sample'
  end
end
