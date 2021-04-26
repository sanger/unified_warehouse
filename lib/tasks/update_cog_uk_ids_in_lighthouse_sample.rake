# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :lighthouse_sample_table do
  desc 'Update lighthouse_sample with cog uk ids from sample'

  # For each positive Lighthouse Sample row, set the Cog UK ID from the matching Sample
  task update_lighthouse_sample_cog_uk_ids: :environment do
    rows_found = 0
    rows_already_set = 0
    rows_no_sample_found = 0
    rows_sample_had_no_supplier_name = 0
    rows_updated = 0

    STDOUT.puts('Updating lighthouse sample table with cog uk ids')

    # Select all lighthouse samples
    LighthouseSample.all.each do |lh_sample|
      STDOUT.puts 'Starting looping through the lighthouse samples' if rows_found.zero?
      rows_found += 1
      STDOUT.puts "On row #{rows_found}" if (rows_found % 100).zero?

      # skip if cog_uk_id already set
      if lh_sample.cog_uk_id.present?
        rows_already_set += 1
        next
      end

      joins_sql = 'INNER JOIN lighthouse_sample ON sample.uuid_sample_lims = lighthouse_sample.lh_sample_uuid '\
      "AND lighthouse_sample.lh_sample_uuid = '#{lh_sample.lh_sample_uuid}'"

      samp = Sample.joins(joins_sql).where.not(
        sample: {
          supplier_name: nil
        }
      ).first

      if samp.present?
         # supplier name may be "" or " ", so need this check
        if samp.supplier_name.blank?
          rows_sample_had_no_supplier_name += 1
          next
        end

        lh_sample.cog_uk_id = samp.supplier_name
        lh_sample.save!
        rows_updated += 1
      else
        rows_no_sample_found += 1
      end
    end

    STDOUT.puts('Done')
    STDOUT.puts("Total rows found: #{rows_found}")
    STDOUT.puts("Rows where cog uk id already set: #{rows_already_set}")
    STDOUT.puts("Rows where supplier name not present on Sample: #{rows_sample_had_no_supplier_name}")
    STDOUT.puts("Rows where no Sample was found: #{rows_no_sample_found}")
    STDOUT.puts("Rows updated with Cog Uk ID: #{rows_updated}")
  end
end
# rubocop:enable Metrics/BlockLength