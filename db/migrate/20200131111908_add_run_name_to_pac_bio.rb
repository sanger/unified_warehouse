class AddRunNameToPacBio < ActiveRecord::Migration
  def change
    add_column :pac_bio_run, :pac_bio_run_name, :string, comment: 'Name of the run'
  end
end
