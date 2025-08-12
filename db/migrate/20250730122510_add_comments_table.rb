class AddCommentsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :comment_value, comment: 'Value of the comment corresponding to the comment_type'
      t.string :batch_id, null: true, comment: 'Corresponds to id_flowcell_lims in iseq_flowcell table.'
      t.string :id_lims, limit: 10, null: false, comment: 'ID of the LIMS'
      t.integer :position, null: true, limit: 2, unsigned: true, comment: 'Position of the lane in the flowcell'
      t.integer :tag_index, null: true, limit: 2, unsigned: true, comment: 'Index of the tag (check iseq_flowcell tag_index column)'
      t.string :comment_type, null: false, comment: 'Type of the comment e.g., under_representation'

      t.timestamps
    end
  end
end
