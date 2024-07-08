class AddInsertSizeToAliquots < ActiveRecord::Migration[7.0]
  def up
    add_column :aliquot, :insert_size, :integer, comment: 'The size of the insert in base pairs'
  end

  def down
    remove_column :aliquot, :insert_size, :integer
  end
end
