class AddQcStatusAndDecisionBy < ActiveRecord::Migration[6.0]
  def change
    add_column :long_read_qc_result, :qc_status, :string, comment: 'Status of QC decision for example pass, fail etc'
    add_column :long_read_qc_result, :qc_status_decision_by, :string, comment: 'Who made the QC status decision for example ToL, Long Read'
  end
end
