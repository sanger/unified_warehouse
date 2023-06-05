# frozen_string_literal: true

# plates need a number to identify them for multi-plate support
class AddPlateNumberToPacbioRun < ActiveRecord::Migration[6.0]
  def change
    change_table :pac_bio_run, bulk: true do |t|
      t.integer :plate_number, comment: 'The number of the plate that goes onto the sequencing machine. Necessary as an identifier for multi-plate support.'
    end
  end
end
