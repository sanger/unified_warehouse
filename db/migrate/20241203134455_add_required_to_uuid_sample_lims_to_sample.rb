class AddRequiredToUuidSampleLimsToSample < ActiveRecord::Migration[7.0]
  def up
    # uuid_sample_lims should be required
    change_column_null(:sample, :uuid_sample_lims, false) 
  end

  def down
    change_column_null(:sample, :uuid_sample_lims, true)
  end
end
