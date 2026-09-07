class RemoveUniquenessOnStudyUuid < ActiveRecord::Migration[8.1]
  def up
    remove_index :study, name: 'study_uuid_study_lims_index'
    add_index :study, :uuid_study_lims, name: 'study_uuid_study_lims_index'
  end

  def down
    remove_index :study, name: 'study_uuid_study_lims_index'
    add_index :study, :uuid_study_lims, name: 'study_uuid_study_lims_index', unique: true
  end
end