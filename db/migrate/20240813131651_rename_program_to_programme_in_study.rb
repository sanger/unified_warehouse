class RenameProgramToProgrammeInStudy < ActiveRecord::Migration[7.0]
  def change
    rename_column :study, :program, :programme
  end
end
