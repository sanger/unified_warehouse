class AddProgramToStudy < ActiveRecord::Migration[7.0]
  def change
    add_column :study, :program, :string
  end
end
