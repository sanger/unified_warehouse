# frozen_string_literal: true

# Rails task to update the id_sample_lims column based on the name column in samples table for samples
# Why is this task needed?
# The id_sample_lims column in the samples table is used to store the ID of the sample in Traction.
# However, this is clashing with IDs in the sample table in the warehouse, causing problems for NPG.
# NPG relies on the uniqueness of these IDs as they use Sequencescape IDs.
# To resolve this issue, we need to update the id_sample_lims column to the value of the name column for samples where id_lims is "Traction".
namespace :sample_table do
  # This rake task updates the id_sample_lims column to the value of the name column
  # for samples where id_lims is "Traction". If the name is already present in the
  # id_sample_lims column, the sample will be skipped.
  #
  # Usage: bundle exec rake sample_table:update_id_sample_lims
  #
  # The task performs the following steps:
  # 1. Fetch all samples where id_lims is "Traction".
  # 2. For each sample, check if the name is already present in the id_sample_lims column.
  # 3. If the name is not present, update the id_sample_lims column to the value of the name column.
  # 4. Skip the sample if the name is already present in the id_sample_lims column.
  #
  desc 'Update id_sample_lims column to the value of the name column if id_lims is "Traction"'

  task update_id_sample_lims: :environment do
    Sample.where(id_lims: 'Traction').find_each do |sample|
      # Skip updating the sample if the id_sample_lims already contains the sample's name
      next if Sample.exists?(id_sample_lims: sample.name)

      puts "Updating id_sample_lims for sample #{sample.id} to #{sample.name}"
      sample.id_sample_lims = sample.name

      begin
        sample.save!
      rescue ActiveRecord::ActiveRecordError, StandardError => e
        puts "Failed to update id_sample_lims for sample #{sample.id}: #{e.message}"
      end
    end
  end
end
