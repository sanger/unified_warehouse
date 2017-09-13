class AddForeignKeyConstraintsToOseqFlowcellTable < ActiveRecord::Migration
  require './lib/foreign_key_constraint'
  include ForeignKeyConstraint

  def up
    add_constraint :oseq_flowcell, :sample, as: :id_sample_tmp, foreign_key: :id_sample_tmp
    add_constraint :oseq_flowcell, :study,  as: :id_study_tmp,  foreign_key: :id_study_tmp
  end

  def down
    drop_constraint :oseq_flowcell, :sample, as: :id_sample_tmp, foreign_key: :id_sample_tmp
    drop_constraint :oseq_flowcell, :study,  as: :id_study_tmp,  foreign_key: :id_study_tmp
  end
end
