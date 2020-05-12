class AddControlTypeToSample < ActiveRecord::Migration
  def change
    add_column :sample, :control_type, :string
  end
end
