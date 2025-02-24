class AddEbiFieldsToStudy < ActiveRecord::Migration[7.0]
  def change
    add_column :study, :ebi_library_strategy, :string, default: nil
    add_column :study, :ebi_library_source, :string, default: nil
    add_column :study, :ebi_library_selection, :string, default: nil
  end
end