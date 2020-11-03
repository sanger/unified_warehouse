class AddForeignKeyConstraintToSampleExtationActivtyTable < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :samples_extraction_activity, :sample, column: :id_sample_tmp, primary_key: :id_sample_tmp
  end
end
