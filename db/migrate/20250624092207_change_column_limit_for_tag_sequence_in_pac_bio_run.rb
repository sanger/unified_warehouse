class ChangeColumnLimitForTagSequenceInPacBioRun < ActiveRecord::Migration[7.2]
  def change
    change_column :pac_bio_run, :tag_sequence, :string, limit: 50
    change_column :pac_bio_run, :tag2_sequence, :string, limit: 50
  end
end
