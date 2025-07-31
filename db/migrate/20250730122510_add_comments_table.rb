class AddCommentsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :batch_id, null: false
      t.string :id_lims, limit: 10, null: false
      t.integer :position, null: false, limit: 2, unsigned: true
      t.integer :tag_index, null: false, limit: 2, unsigned: true

      t.timestamps
    end
  end
end
