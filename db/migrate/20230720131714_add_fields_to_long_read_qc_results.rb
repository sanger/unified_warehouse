class AddFieldsToLongReadQcResults < ActiveRecord::Migration[7.0]
  def change
    add_column :long_read_qc_result, :priority_level, :string, comment: 'Priority level eg Medium, High etc'
    add_column :long_read_qc_result, :date_required_by, :string, comment: 'Date required by eg tol, etc'
    add_column :long_read_qc_result, :reason_for_priority, :string, comment: 'Reason for priority'
  end
end
