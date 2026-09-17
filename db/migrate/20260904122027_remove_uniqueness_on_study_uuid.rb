# frozen_string_literal: true

class RemoveUniquenessOnStudyUuid < ActiveRecord::Migration[8.1]
  def up
    change_table :study, bulk: true do |t|
      t.remove_index name: 'study_uuid_study_lims_index'
      t.index %i[uuid_study_lims id_lims], name: 'study_uuid_study_lims_index', unique: true
    end
  end

  def down
    change_table :study, bulk: true do |t|
      t.remove_index name: 'study_uuid_study_lims_index'
      t.index :uuid_study_lims, name: 'study_uuid_study_lims_index', unique: true
    end
  end
end
