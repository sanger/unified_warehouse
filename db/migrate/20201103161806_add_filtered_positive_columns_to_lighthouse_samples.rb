# frozen_string_literal: true

# Adds the filtered positive columns to the lighthouse_sample table
class AddFilteredPositiveColumnsToLighthouseSamples < ActiveRecord::Migration[4.2]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.boolean :filtered_positive, null: true, comment: 'Filtered positive result value', after: :ch4_cq
      t.string :filtered_positive_version, null: true, comment: 'Filtered positive version', after: :filtered_positive
      t.datetime :filtered_positive_timestamp, null: true, comment: 'Filtered positive timestamp', after: :filtered_positive_version
    end
  end
end
