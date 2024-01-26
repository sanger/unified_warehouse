# frozen_string_literal: true

namespace :pac_bio_run_table do
  desc 'Update pac_bio_run_name column with the values from id_pac_bio_run_lims'

  task update_pac_bio_run_name: :environment do
    PacBioRun.find_each do |run|
      next if run.pac_bio_run_name.present?

      run.pac_bio_run_name = run.id_pac_bio_run_lims
      run.save!
    end
  end
end
