class AddIndexForIdStudyLimsInStudyTable < ActiveRecord::Migration[7.0]
  def change
    add_index :study, :id_study_lims, unique: true
  end
end
