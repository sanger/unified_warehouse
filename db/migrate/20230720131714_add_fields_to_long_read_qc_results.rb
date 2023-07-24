# frozen_string_literal: true

# Adds new optional fields to long_read_qc_result
class AddFieldsToLongReadQcResults < ActiveRecord::Migration[7.0]
  def change
    change_table :long_read_qc_result, bulk: true do |t|
      t.string :priority_level, comment: 'Priority level eg Medium, High etc'
      t.string :date_required_by, comment: 'Date required by eg tol, etc'
      t.string :reason_for_priority, comment: 'Reason for priority'
    end
  end
end
