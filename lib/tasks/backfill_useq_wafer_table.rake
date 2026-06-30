# frozen_string_literal: true

# This is a one-time rake task to backfill the `useq_wafer` table with runs related to study
# `HG_WC11479_IBD\-Bioresource\_WES`, completed prior to LIMS support.
# Y26-130

STUDY_NAME = 'HG_WC11479_IBD-Bioresource_WES'
ID_LIMS = 'NPG DATA'

# rubocop:disable Metrics/BlockLength
namespace :useq_wafer_table do
  desc 'backfill useq_wafer records'

  task up: :environment do
    sql = <<~SQL.squish
      INSERT INTO useq_wafer (
          recorded_at,
          last_updated,
          id_sample_tmp,
          id_study_tmp,
          id_wafer_lims,
          batch_for_opentrons,
          id_lims,
          request_order,
          entity_type,
          tag_sequence,
          id_pool_lims,
          entity_id_lims,
          requested_sequencer_type
      )
      SELECT
          now(),
          urm.last_changed,
          s.id_sample_tmp,
          sr.id_study_tmp,
          urm.ultimagen_Library_Pool,
          urm.id_run,
          '#{ID_LIMS}',
          0,
          CASE
            WHEN upm.ultimagen_Index_Sequence IS NOT NULL
              THEN 'library_indexed'
            ELSE 'library'
          END,
          upm.ultimagen_Index_Sequence,
          'N/A',
          'N/A',
          urm.instrument_model
      FROM useq_product_metrics upm
      INNER JOIN useq_run_metrics urm
        ON urm.id_run = upm.id_run
      INNER JOIN sample s
        ON s.name = upm.ultimagen_Library_Name
      INNER JOIN stock_resource sr
        ON sr.id_sample_tmp = s.id_sample_tmp
      INNER JOIN study st
        ON st.id_study_tmp = sr.id_study_tmp
      WHERE upm.id_useq_wafer_tmp IS NULL
        AND st.name = '#{STUDY_NAME}';
    SQL

    puts 'Running UP backfill...'
    ActiveRecord::Base.connection.execute(sql)
    puts 'Done.'
  end

  desc 'rollback useq_wafer backfill'
  task down: :environment do
    sql = <<~SQL.squish
      DELETE FROM useq_wafer
        WHERE id_lims = '#{ID_LIMS}';
    SQL

    puts 'Running DOWN rollback...'
    ActiveRecord::Base.connection.execute(sql)
    puts 'Rollback complete.'
  end
end
# rubocop:enable Metrics/BlockLength
