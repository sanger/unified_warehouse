# frozen_string_literal: true

# Updates all sequncescape pac bio runs to have the plate number 1

namespace :pac_bio_run_table do
  desc 'Update pac_bio_run_name plate_number column with the value 1 for sequencescape plates'

  task update_pac_bio_run_sequencescape_plate_numbers: :environment do
    PacBioRun.all.each do |run|
      next if run.id_lims != 'SQSCP'

      run.plate_number = 1
      run.save!
    end
  end
end
