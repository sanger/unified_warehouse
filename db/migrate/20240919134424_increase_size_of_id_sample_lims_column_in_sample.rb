class IncreaseSizeOfIdSampleLimsColumnInSample < ActiveRecord::Migration[7.0]
  def up
    change_column :sample, :id_sample_lims, :string, limit: 255
  end

  def down
    change_column :sample, :id_sample_lims, :string, limit: 20
  end
end
