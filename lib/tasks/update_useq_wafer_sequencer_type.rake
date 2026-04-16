# frozen_string_literal: true

# This task updates the useq_wafer table to set the sequencer_type to 'UG100' for all records where it is currently nil.
# To run this task, use the following command:
#   bundle exec rake useq_wafer_table:update_sequencer_type_to_ug100 COMMIT=true

namespace :useq_wafer_table do
  desc "Update useq_wafer.sequencer_type from nil to 'UG100'"

  task update_sequencer_type_to_ug100: :environment do
    # Find records where sequencer_type is nil
    records_to_update = UseqWafer.where(sequencer_type: nil)
    count = records_to_update.count
    ids = records_to_update.pluck(:id_useq_wafer_tmp)

    puts "Found #{count} records with nil sequencer_type"
    puts "Record IDs to update: #{ids.join(', ')}" unless ids.empty?

    # Handle commit flag
    commit = ENV['COMMIT'] == 'true'

    update_count = 0
    records_to_update.find_each do |wafer|
      wafer.sequencer_type = 'UG100'
      update_count += 1
      next unless commit

      wafer.save!
    end

    if commit
      puts "✓ Successfully updated #{update_count} records with sequencer_type='UG100'"
    else
      puts "Would update #{update_count} records with sequencer_type='UG100'"
      puts '⚠ No commit yet. Run with COMMIT=true to save the changes.'
    end
  end
end
