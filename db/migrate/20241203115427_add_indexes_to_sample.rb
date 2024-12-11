class AddIndexesToSample < ActiveRecord::Migration[7.0]

  def change
    #id_lims and id_sample_lims should be unique together
    add_index :sample, [:id_lims, :id_sample_lims], unique: true

    #improve search performance
    add_index :sample, :id_lims, unique: false
    add_index :sample, :id_sample_lims, unique: false
  end
end
