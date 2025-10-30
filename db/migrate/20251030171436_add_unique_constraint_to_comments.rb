class AddUniqueConstraintToComments < ActiveRecord::Migration[7.2]
  def change
    add_constraint :comments,
                   :comments_unique_constraint,
                   unique: [:batch_id, :id_lims, :position, :tag_index, :comment_type, :comment_value]
  end
end
