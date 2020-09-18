# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :lighthouse_sample_table do
  desc 'Update lighthouse_sample with cog uk ids from sample'

  # For each positive Lighthouse Sample row, set the Cog UK ID from the matching Sample
  task update_lighthouse_sample_cog_uk_ids: :environment do
    rows_found = 0
    rows_already_set = 0
    rows_no_sample_found = 0
    rows_sample_had_no_cog_uk_id = 0
    rows_updated = 0

    STDOUT.puts('Updating lighthouse sample table with cog uk ids')

    # only select positives, as only positives have cog_uk_ids
    LighthouseSample.where(result: 'positive').each do |lh_sample|
      rows_found += 1

      # skip if cog_uk_id already set
      if lh_sample.cog_uk_id.present?
        rows_already_set += 1
        next
      end

      # fetch cog_uk_id from sample where root_sample_id and result match, and
      # joining via stock_resource to match on plate_barcode and coordinate
      joins_sql = 'INNER JOIN stock_resource ON sample.id_sample_tmp = stock_resource.id_sample_tmp '\
      "AND stock_resource.labware_human_barcode = '#{lh_sample.plate_barcode}' "\
      "AND stock_resource.labware_coordinate = '#{lh_sample.coordinate}'"

      samp = Sample.joins(joins_sql).where(
        sample: {
          description: lh_sample.root_sample_id,
          phenotype: lh_sample.result
        }
      ).first

      if samp.present?
        if samp.supplier_name.blank?
          rows_sample_had_no_cog_uk_id += 1
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
    STDOUT.puts("Total rows for positives found: #{rows_found}")
    STDOUT.puts("Rows where cog uk id already set: #{rows_already_set}")
    STDOUT.puts("Rows where cog uk id not present on Sample: #{rows_sample_had_no_cog_uk_id}")
    STDOUT.puts("Rows updated with Cog Uk ID: #{rows_updated}")
  end
end
# rubocop:enable Metrics/BlockLength
