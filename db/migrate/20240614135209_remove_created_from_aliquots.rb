class RemoveCreatedFromAliquots < ActiveRecord::Migration[7.0]
  def change
    def up
      remove_column :aliquots, :created, :datetime
    end

    def down
      add_column :aliquots, :created, :datetime
    end
  end
end
