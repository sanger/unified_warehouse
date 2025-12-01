class RenameColumnsInComments < ActiveRecord::Migration[7.2]
  def change
    rename_column :comments, :created_at, :recorded_at
    rename_column :comments, :updated_at, :last_updated
    change_column_comment :comments, :last_updated, "The date the comment was last updated in LIMS."
    change_column_comment :comments, :recorded_at, "Timestamp of the latest warehouse update."
  end
end
