# frozen_string_literal: true

namespace :useq_wafer_table do
  desc "Update useq_wafer records with nil sequencer_type to 'UG100'"

  task update_sequencer_type_to_ug100: :environment do
    updated_count = UseqWafer.where(sequencer_type: nil).update_all(sequencer_type: 'UG100')
    puts "Updated #{updated_count} records"
  end
end
