# frozen_string_literal: true

# Added the qc status and who that decision was made by columns to long_read_qc_result
class AddQcStatusAndDecisionBy < ActiveRecord::Migration[6.0]
  def change
    change_table :long_read_qc_result, bulk: true do |t|
      t.string :qc_status, comment: 'Status of the QC decision eg pass, fail etc'
      t.string :qc_status_decision_by, comment: 'Who made the QC status decision eg ToL, Long Read'
    end
  end
end
