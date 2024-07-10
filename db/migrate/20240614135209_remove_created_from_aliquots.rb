class RemoveCreatedFromAliquots < ActiveRecord::Migration[7.0]
  def up
    remove_column :aliquot, :created, :datetime
    # we will never need this column again, so we can remove it
    remove_column :aliquot, :deleted_at, :datetime
    add_column :aliquot, :created_at, :datetime, null: false, comment: 'The date and time that this record was created'
    change_column_null :aliquot, :recorded_at, false
  end

  def down
    add_column :aliquot, :created, :datetime
    add_column :aliquot, :deleted_at, :datetime
    remove_column :aliquot, :created_at, :datetime
    change_column_null :aliquot, :recorded_at, true
  end
end
