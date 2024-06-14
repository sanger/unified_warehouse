class RemoveCreatedFromAliquots < ActiveRecord::Migration[7.0]
  def up
    remove_column :aliquot, :created, :datetime
  end

  def down
    add_column :aliquot, :created, :datetime
  end
end
