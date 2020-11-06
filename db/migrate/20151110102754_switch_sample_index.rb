class SwitchSampleIndex < ActiveRecord::Migration
  def change
    remove_index :sample, column: %i[id_lims id_sample_lims], name: 'sample_id_lims_id_sample_lims_index'
    add_index :sample, %i[id_sample_lims id_lims], unique: true
  end
end
