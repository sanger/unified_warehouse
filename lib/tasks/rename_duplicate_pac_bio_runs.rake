# frozen_string_literal: true

namespace :pac_bio_run_table do
  desc 'Update pac_bio_run_name column with the values from id_pac_bio_run_lims'

  task rename_duplicate_pac_bio_runs: :environment do
    list_of_runs = [70_489, 99_999]
    PacBioRun.where(id_pac_bio_run_lims: list_of_runs).each do |pac_bio_run|
      pac_bio_run.update(id_pac_bio_run_lims: 'MIGRATED_DPL269_' + pac_bio_run.id_pac_bio_run_lims)
    end
  end
end
