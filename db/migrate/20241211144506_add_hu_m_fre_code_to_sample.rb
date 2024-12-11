class AddHuMFreCodeToSample < ActiveRecord::Migration[7.0]
  def change
    add_column :sample, :huMFre_code, :string, limit: 16
  end
end
