# frozen_string_literal: true

# Adding priority_level eg Medium, High etc to recieve this information
# in a sample message from TOL through traction receptions endpoint
class AddPriorityLevelToSample < ActiveRecord::Migration[7.0]
  def change
    change_table :sample, bulk: true do |t|
      t.string :priority_level, comment: 'Priority level eg Medium, High etc'
    end
  end
end
