# frozen_string_literal: true

# Adding priority_level e.g. Medium, High etc to receive this information
# in a sample message from TOL through traction qc_receptions endpoint
class AddPriorityLevelToSample < ActiveRecord::Migration[7.0]
  def change
    change_table :sample, bulk: true do |t|
      t.string :priority_level, comment: 'Priority level e.g. Medium, High etc'
    end
  end
end
