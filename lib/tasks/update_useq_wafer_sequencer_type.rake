# frozen_string_literal: true

namespace :useq_wafer_table do
  desc "Update useq_wafer records with nil sequencer_type to 'UG100'"

  task update_sequencer_type_to_ug100: :environment do
    updated_count = 0

    UseqWafer.where(sequencer_type: nil).find_each do |wafer|
      wafer.sequencer_type = 'UG100'
      wafer.save!
      updated_count += 1
    end

    puts "Updated #{updated_count} records"
  end
end
