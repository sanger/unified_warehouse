class RemoveStudyUuidUniqueIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :study, :uuid_study_lims, unique: true
  end
end
