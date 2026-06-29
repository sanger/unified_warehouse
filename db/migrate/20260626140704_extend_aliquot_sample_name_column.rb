class ExtendAliquotSampleNameColumn < ActiveRecord::Migration[7.2]
  def up
    change_column :aliquot, :sample_name, :string, limit: 512
    change_column_comment :aliquot, :sample_name, 'The name of the sample, or colon separated list of sample names, that the aliquot was created from'
  end
end
