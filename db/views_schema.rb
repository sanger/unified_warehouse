# This is an automatically generated file by rake:db:views:dump_schema
view_schema_mlwh_db = Rails.configuration.view_schema_mlwh_db
view_schema_ewh_db = Rails.configuration.view_schema_ewh_db

ViewsSchema.update_view(
    'cherrypicked_samples',
    <<~SQL.squish
      SELECT mlwh_sample.description AS "root_sample_id", mlwh_stock_resource.labware_human_barcode AS "plate_barcode",
      mlwh_sample.phenotype AS "phenotype", mlwh_stock_resource.labware_coordinate AS "coordinate",
      mlwh_sample.created AS "created", "Tecan" as "robot_type"
      FROM #{view_schema_mlwh_db}.sample AS mlwh_sample
      JOIN #{view_schema_mlwh_db}.stock_resource AS mlwh_stock_resource ON (mlwh_sample.id_sample_tmp = mlwh_stock_resource.id_sample_tmp)
      JOIN #{view_schema_ewh_db}.subjects mlwh_events_subjects ON (mlwh_events_subjects.friendly_name = mlwh_sample.sanger_sample_id)
      JOIN #{view_schema_ewh_db}.roles mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
      JOIN #{view_schema_ewh_db}.events mlwh_events_events ON (mlwh_events_roles.event_id = mlwh_events_events.id)
      JOIN #{view_schema_ewh_db}.event_types mlwh_events_event_types ON (mlwh_events_events.event_type_id = mlwh_events_event_types.id)
      WHERE mlwh_events_event_types.key = "cherrypick_layout_set"
      UNION
      SELECT mlwh_sample.description AS "root_sample_id", mlwh_lh_sample.plate_barcode AS "plate_barcode",
      mlwh_sample.phenotype AS "phenotype", mlwh_lh_sample.coordinate AS "coordinate", mlwh_sample.created AS "created",
      "Beckman" as "robot_type"
      FROM #{view_schema_mlwh_db}.sample as mlwh_sample
      JOIN #{view_schema_mlwh_db}.lighthouse_sample AS mlwh_lh_sample ON (mlwh_sample.uuid_sample_lims = mlwh_lh_sample.lh_sample_uuid)
      JOIN #{view_schema_ewh_db}.subjects AS mlwh_events_subjects ON (mlwh_events_subjects.uuid = UNHEX(REPLACE(mlwh_lh_sample.lh_sample_uuid, '-', '')))
      JOIN #{view_schema_ewh_db}.roles AS mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
      JOIN #{view_schema_ewh_db}.events AS mlwh_events_events ON (mlwh_events_events.id = mlwh_events_roles.event_id)
      JOIN #{view_schema_ewh_db}.event_types AS mlwh_events_event_types ON (mlwh_events_event_types.id = mlwh_events_events.event_type_id)
      WHERE mlwh_events_event_types.key = "lh_beckman_cp_destination_created"
    SQL
)
