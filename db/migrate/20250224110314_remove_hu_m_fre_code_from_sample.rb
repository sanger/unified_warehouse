class RemoveHuMFreCodeFromSample < ActiveRecord::Migration[7.0]
  def change
    remove_column :sample, :huMFre_code, :string
  end
end
