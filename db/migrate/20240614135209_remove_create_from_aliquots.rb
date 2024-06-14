class RemoveCreateFromAliquots < ActiveRecord::Migration[7.0]
  def change
    def up
      remove_column :aliquots, :create, :string
    end

    def down
      add_column :aliquots, :create, :string
    end
  end
end
