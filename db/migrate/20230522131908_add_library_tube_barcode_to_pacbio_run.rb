# frozen_string_literal: true

# Adds library tube barcode column to pac_bio_run and removes the validation for plate_barcodes precense
class AddLibraryTubeBarcodeToPacbioRun < ActiveRecord::Migration[6.1]
  def up
    change_table :pac_bio_run, bulk: true do |t|
      t.string :pac_bio_library_tube_barcode, comment: 'The barcode of the originating library tube'
    end
    change_column :pac_bio_run, :plate_barcode, :string, null: true
  end

  def down
    change_table :pac_bio_run, bulk: true do |t|
      t.remove :pac_bio_library_tube_barcode
    end
    # Here we add a placeholder value in case any plate barcodes were added as null since the migration
    PacBioRun.where(plate_barcode: nil).each do |run|
      run.plate_barcode = 'plate_barcode placeholder'
      run.save
    end
    change_column :pac_bio_run, :plate_barcode, :string, null: false
  end
end
