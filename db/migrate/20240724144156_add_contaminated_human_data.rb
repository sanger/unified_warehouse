class AddContaminatedHumanData < ActiveRecord::Migration[7.0]
  def change
    add_column :study, :contaminated_human_data_access_group, :string, default: nil
  end
end
