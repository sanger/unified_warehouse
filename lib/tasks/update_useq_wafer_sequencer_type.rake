# frozen_string_literal: true

namespace :useq_wafer_table do
  # This is 'one time run' rake task to back fill the sequencer_type column to 'UG 100' for all records in the useq_wafer table
  # after the 'requested_sequencer_type' column is added to the useq_wafer table in the database and the value is nil for all existing records.
  # After there is other data (e.g.UG 200) in the table, this task should not be run again.
  # Usage: bundle exec rake useq_wafer_table:update_requested_sequencer_type_to_ug100

  desc "Update useq_wafer records with nil requested_sequencer_type to 'UG 100'"

  task update_requested_sequencer_type_to_ug100: :environment do
    updated_count = 0

    UseqWafer.where(requested_sequencer_type: nil).find_each do |wafer|
      wafer.requested_sequencer_type = 'UG 100'
      wafer.save!
      updated_count += 1
    end

    puts "Updated #{updated_count} records"
  end
end
