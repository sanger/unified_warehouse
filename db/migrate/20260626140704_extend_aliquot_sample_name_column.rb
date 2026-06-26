class ExtendAliquotSampleNameColumn < ActiveRecord::Migration[7.2]
  def change
    change_column :aliquot, :sample_name, :string, limit: 512
  end
end
