class AddForeignKeyConstraintsToPacbio < ActiveRecord::Migration

  require './lib/foreign_key_constraint'
  include ForeignKeyConstraint

  def up
    add_constraint :pac_bio_run, :sample, as: :id_sample_tmp, foreign_key: :id_sample_tmp
    add_constraint :pac_bio_run, :study,  as: :id_study_tmp,  foreign_key: :id_study_tmp
  end

  def down
    drop_constraint :pac_bio_run, :sample, as: :id_sample_tmp, foreign_key: :id_sample_tmp
    drop_constraint :pac_bio_run, :study,  as: :id_study_tmp,  foreign_key: :id_study_tmp
  end
end
