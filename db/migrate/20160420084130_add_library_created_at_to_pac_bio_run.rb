class AddLibraryCreatedAtToPacBioRun < ActiveRecord::Migration
  def change
    change_table :pac_bio_run do |t|
      t.datetime :library_created_at, null: true, comment: 'Timestamp of library creation'
    end
  end
end
