# frozen_string_literal: true

# This task updates the useq_wafer table to set the sequencer_type to 'UG100' for all records where it is currently nil.
# It also creates a backup of the useq_wafer table before making any changes, and prints out the IDs of the records that will be updated.
# To run this task, use the following command:
#   bundle exec rake useq_wafer_table:update_sequencer_type_to_ug100 COMMIT=true

# rubocop:disable Metrics/BlockLength
namespace :useq_wafer_table do
  desc "Update useq_wafer.sequencer_type from nil to 'UG100'"

  task update_sequencer_type_to_ug100: :environment do
    output_lines = []
    log_output = lambda do |message = ''|
      output_lines << message
      puts message
    end

    # 1. Save a copy of the table
    log_output.call 'Step 1: Saving backup of useq_wafer table...'
    backup_filename = "useq_wafer_backup_#{Time.current.utc.strftime('%Y%m%d%H%M%S')}.json"
    backup_path = Rails.root.join('tmp', backup_filename)
    all_records = UseqWafer.all.to_a
    File.write(backup_path, all_records.to_json)
    log_output.call "✓ Backup saved to #{backup_path}"
    log_output.call

    # 2 & 3. Find records where sequencer_type is nil and get count
    records_to_update = UseqWafer.where(sequencer_type: nil)
    count = records_to_update.count
    ids = records_to_update.pluck(:id_useq_wafer_tmp)

    log_output.call "Step 2-3: Found #{count} records with nil sequencer_type"
    log_output.call

    # 4. Print out the id_useq_wafer_tmp
    if ids.any?
      log_output.call 'Step 4: Record IDs to be updated:'
      ids.each { |id| log_output.call "  - #{id}" }
      log_output.call
    end

    # 5. Handle commit flag
    commit = ENV['COMMIT'] == 'true' || ARGV.include?('-commit')

    would_update_count = 0
    updated_count = 0
    records_to_update.find_each do |wafer|
      wafer.sequencer_type = 'UG100'
      would_update_count += 1
      next unless commit

      wafer.save!
      updated_count += 1
    end

    if commit
      log_output.call "✓ Successfully updated #{updated_count} records with sequencer_type='UG100'"
    else
      log_output.call "Would update #{would_update_count} records with sequencer_type='UG100'"
      log_output.call '⚠ No commit yet. Run with COMMIT=true to save the changes.'
      log_output.call '  Example: bundle exec rake useq_wafer_table:update_sequencer_type_to_ug100 COMMIT=true'
    end

    output_filename = "useq_wafer_sequencer_type_output_#{Time.current.utc.strftime('%Y%m%d%H%M%S')}.log"
    output_path = Rails.root.join('tmp', output_filename)
    File.write(output_path, "#{output_lines.join("\n")}\n")
    puts "Output written to #{output_path}"
  end
end
# rubocop:enable Metrics/BlockLength
