# frozen_string_literal: true

# Adds the sample and source plate uuid columns to the lighthouse_sample table
class AddUuidColumnsToLighthouseSamples < ActiveRecord::Migration[6.0]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.string :lh_sample_uuid, limit: 36, null: true, comment: 'Sample uuid created in crawler', after: :filtered_positive_timestamp
      t.string :lh_source_plate_uuid, limit: 36, null: true, comment: 'Source plate uuid created in crawler', after: :lh_sample_uuid
    end
  end
end
