class AddCommentsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :batch_id, null: false

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
    execute <<-SQL
      ALTER TABLE comments
      ADD CONSTRAINT fk_comments_iseq_flowcell
      FOREIGN KEY (batch_id, position, tag_index)
      REFERENCES iseq_flowcell(id_flowcell_lims, position, tag_index);
    SQL
  end
end
