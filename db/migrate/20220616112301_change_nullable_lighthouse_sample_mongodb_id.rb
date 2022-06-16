# frozen_string_literal: true

#
# This migration disables NOT NULL to the mongodb_id column because the plan is
# this table will be maintained by GSU team and they won't use that column anymore
class ChangeNullableLighthouseSampleMongodbId < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:lighthouse_sample, :mongodb_id, true)
  end
end
