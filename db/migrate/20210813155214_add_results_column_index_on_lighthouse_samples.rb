# frozen_string_literal: true

# Add index for the result column on lighthouse samples to speed up KPI queries
# looking specifically at positive results.
class AddResultsColumnIndexOnLighthouseSamples < ActiveRecord::Migration[6.0]
  def up
    add_index :lighthouse_sample, :result
  end

  def down
    remove_index :lighthouse_sample, :result
  end
end
