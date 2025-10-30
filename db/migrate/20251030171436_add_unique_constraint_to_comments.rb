class AddUniqueConstraintToComments < ActiveRecord::Migration[7.2]
  def change
    add_index :comments,
              %i[batch_id id_lims position tag_index comment_type comment_value],
              unique: true, name: 'comments_unique_constraint', length: { comment_value: 255 }  # specify prefix length for TEXT/BLOB
  end
end
