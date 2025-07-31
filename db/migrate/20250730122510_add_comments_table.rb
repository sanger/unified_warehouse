class AddCommentsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :batch_id, null: false
      t.string :id_lims, limit: 10, null: false
      t.timestamps
    end
    add_column :comments, :position, :integer, limit: 2, null: false
    execute <<-SQL
      ALTER TABLE comments
      MODIFY COLUMN position SMALLINT UNSIGNED;
    SQL
    add_column :comments, :tag_index, :integer, limit: 2, null: false
    execute <<-SQL
      ALTER TABLE comments
      MODIFY COLUMN tag_index SMALLINT UNSIGNED;
    SQL
  end
end
