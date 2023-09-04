# frozen_string_literal: true

# Updates all sequencescape pac_bio_run entries to have the plate number 1

namespace :pac_bio_run_table do
  desc 'Update pac_bio_run plate_number column with the value 1 for sequencescape plates'

  task update_pac_bio_run_sequencescape_plate_numbers: :environment do
    PacBioRun.where(id_lims: 'SQSCP').each do |run|
      run.plate_number = 1
      run.save!
    end
  end
end
