class AddIsCurrentToStudy < ActiveRecord::Migration[7.2]
  def change
    add_column :study, :is_current, :boolean, null: true, default: true, comment: 'Indicates if this study is the current version'
  end
end
