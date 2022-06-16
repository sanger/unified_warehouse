class ChangeNullableLighthouseSampleMongodbId < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:lighthouse_sample, :mongodb_id, true)
  end
end
