# frozen_string_literal: true

# Creates a view of all cherrypicked samples
class AddCherrypickedSamplesView < ActiveRecord::Migration[6.0]
  def up
    event_wh_db = Rails.application.config.event_wh_db
    execute <<-SQL.squish
      CREATE VIEW cherrypicked_samples AS
      SELECT mlwh_sample.description AS "root_sample_id", mlwh_stock_resource.labware_human_barcode AS "plate_barcode", mlwh_sample.phenotype AS "phenotype",
      mlwh_stock_resource.labware_coordinate AS "coordinate", mlwh_sample.created AS "created"
      FROM sample AS mlwh_sample
      JOIN stock_resource AS mlwh_stock_resource ON (mlwh_sample.id_sample_tmp = mlwh_stock_resource.id_sample_tmp)
      JOIN #{event_wh_db}.subjects mlwh_events_subjects ON (mlwh_events_subjects.friendly_name = mlwh_sample.sanger_sample_id)
      JOIN #{event_wh_db}.roles mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
      JOIN #{event_wh_db}.events mlwh_events_events ON (mlwh_events_roles.event_id = mlwh_events_events.id)
      JOIN #{event_wh_db}.event_types mlwh_events_event_types ON (mlwh_events_events.event_type_id = mlwh_events_event_types.id)
      WHERE mlwh_events_event_types.key = "cherrypick_layout_set"
      UNION
      SELECT mlwh_sample.description AS "root_sample_id", mlwh_lh_sample.plate_barcode AS "plate_barcode", mlwh_sample.phenotype AS "phenotype",
      mlwh_lh_sample.coordinate AS "coordinate", mlwh_sample.created AS "created"
      FROM sample as mlwh_sample
      JOIN lighthouse_sample AS mlwh_lh_sample ON (mlwh_sample.uuid_sample_lims = mlwh_lh_sample.lh_sample_uuid)
      JOIN #{event_wh_db}.subjects AS mlwh_events_subjects ON (mlwh_events_subjects.uuid = UNHEX(REPLACE(mlwh_lh_sample.lh_sample_uuid, '-', '')))
      JOIN #{event_wh_db}.roles AS mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
      JOIN #{event_wh_db}.events AS mlwh_events_events ON (mlwh_events_events.id = mlwh_events_roles.event_id)
      JOIN #{event_wh_db}.event_types AS mlwh_events_event_types ON (mlwh_events_event_types.id = mlwh_events_events.event_type_id)
      WHERE mlwh_events_event_types.key = "lh_beckman_cp_destination_created"
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP VIEW IF EXISTS cherrypicked_samples
    SQL
  end
end
