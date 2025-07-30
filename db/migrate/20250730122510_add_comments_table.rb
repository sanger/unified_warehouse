class AddCommentsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :batch_id, null: false

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE comments
      ADD COLUMN position SMALLINT UNSIGNED NOT NULL;
    SQL
    execute <<-SQL
      ALTER TABLE comments
      ADD COLUMN tag_index SMALLINT UNSIGNED NOT NULL;
    SQL
    execute <<-SQL
      ALTER TABLE comments
      ADD CONSTRAINT fk_comments_iseq_flowcell
      FOREIGN KEY (batch_id, position, tag_index)
      REFERENCES iseq_flowcell(id_flowcell_lims, position, tag_index)
    SQL
  end
end
