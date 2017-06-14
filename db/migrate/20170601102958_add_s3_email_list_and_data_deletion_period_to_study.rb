class AddS3EmailListAndDataDeletionPeriodToStudy < ActiveRecord::Migration
  def change
    change_table(:study) do |t|
      t.string(:s3_email_list, :null => true, :default => nil)
      t.string(:data_deletion_period, :null => true, :default => nil)
    end
  end
end
