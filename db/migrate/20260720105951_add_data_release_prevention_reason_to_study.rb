class AddDataReleasePreventionReasonToStudy < ActiveRecord::Migration[7.2]
  def change
    add_column :study, :data_release_prevention_reason, :string, limit: 255, null: true, default: nil, comment: 'Reason for preventing data release for this study'
  end
end
