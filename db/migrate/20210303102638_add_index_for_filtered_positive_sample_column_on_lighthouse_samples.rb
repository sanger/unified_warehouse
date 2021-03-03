# frozen_string_literal: true

# Adds an index to the filtered positives column on lighthouse sample
class AddIndexForFilteredPositiveSampleColumnOnLighthouseSamples < ActiveRecord::Migration[6.0]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.index :filtered_positive
    end
  end
end
