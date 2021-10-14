# frozen_string_literal: true

# Change the events security to allow for better portability between databases
# The DBAs manage a weekly task which dumps the production event_warehouse
# into a separate database. This proves very useful for training purposes
# and is an integration point for several users who are otherwise
# disconnected from our development environments.

# However, the admin user on the production environment didn't exist,
# which caused issues accessing the view. While an appropriate admin
# user has been registered, the DBAs would like to restrict its
# privileges. This change ensures they can be limited completely.
class UpdateCherrypickedSamplesView < ActiveRecord::Migration[6.0]
  def up
    event_wh_db = Rails.application.config.event_wh_db
    mlwh_wh_db = Rails.configuration.database_configuration[Rails.env]['database']

    ViewsSchema.update_view(
      'cherrypicked_samples',
      <<~SQL.squish,
        SELECT mlwh_sample.description AS "root_sample_id", mlwh_stock_resource.labware_human_barcode AS "plate_barcode",
        mlwh_sample.phenotype AS "phenotype", mlwh_stock_resource.labware_coordinate AS "coordinate",
        mlwh_sample.created AS "created", "Tecan" as "robot_type"
        FROM #{mlwh_wh_db}.sample AS mlwh_sample
        JOIN #{mlwh_wh_db}.stock_resource AS mlwh_stock_resource ON (mlwh_sample.id_sample_tmp = mlwh_stock_resource.id_sample_tmp)
        JOIN #{event_wh_db}.subjects mlwh_events_subjects ON (mlwh_events_subjects.friendly_name = mlwh_sample.sanger_sample_id)
        JOIN #{event_wh_db}.roles mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
        JOIN #{event_wh_db}.events mlwh_events_events ON (mlwh_events_roles.event_id = mlwh_events_events.id)
        JOIN #{event_wh_db}.event_types mlwh_events_event_types ON (mlwh_events_events.event_type_id = mlwh_events_event_types.id)
        WHERE mlwh_events_event_types.key = "cherrypick_layout_set"
        UNION
        SELECT mlwh_sample.description AS "root_sample_id", mlwh_lh_sample.plate_barcode AS "plate_barcode",
        mlwh_sample.phenotype AS "phenotype", mlwh_lh_sample.coordinate AS "coordinate", mlwh_sample.created AS "created",
        "Beckman" as "robot_type"
        FROM #{mlwh_wh_db}.sample as mlwh_sample
        JOIN #{mlwh_wh_db}.lighthouse_sample AS mlwh_lh_sample ON (mlwh_sample.uuid_sample_lims = mlwh_lh_sample.lh_sample_uuid)
        JOIN #{event_wh_db}.subjects AS mlwh_events_subjects ON (mlwh_events_subjects.uuid = UNHEX(REPLACE(mlwh_lh_sample.lh_sample_uuid, '-', '')))
        JOIN #{event_wh_db}.roles AS mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
        JOIN #{event_wh_db}.events AS mlwh_events_events ON (mlwh_events_events.id = mlwh_events_roles.event_id)
        JOIN #{event_wh_db}.event_types AS mlwh_events_event_types ON (mlwh_events_event_types.id = mlwh_events_events.event_type_id)
        WHERE mlwh_events_event_types.key = "lh_beckman_cp_destination_created"
      SQL
      security: 'INVOKER'
    )
  end

  def down
    event_wh_db = Rails.application.config.event_wh_db
    mlwh_wh_db = Rails.configuration.database_configuration[Rails.env]['database']

    ViewsSchema.update_view(
      'cherrypicked_samples',
      <<~SQL.squish,
        SELECT mlwh_sample.description AS "root_sample_id", mlwh_stock_resource.labware_human_barcode AS "plate_barcode",
        mlwh_sample.phenotype AS "phenotype", mlwh_stock_resource.labware_coordinate AS "coordinate",
        mlwh_sample.created AS "created", "Tecan" as "robot_type"
        FROM #{mlwh_wh_db}.sample AS mlwh_sample
        JOIN #{mlwh_wh_db}.stock_resource AS mlwh_stock_resource ON (mlwh_sample.id_sample_tmp = mlwh_stock_resource.id_sample_tmp)
        JOIN #{event_wh_db}.subjects mlwh_events_subjects ON (mlwh_events_subjects.friendly_name = mlwh_sample.sanger_sample_id)
        JOIN #{event_wh_db}.roles mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
        JOIN #{event_wh_db}.events mlwh_events_events ON (mlwh_events_roles.event_id = mlwh_events_events.id)
        JOIN #{event_wh_db}.event_types mlwh_events_event_types ON (mlwh_events_events.event_type_id = mlwh_events_event_types.id)
        WHERE mlwh_events_event_types.key = "cherrypick_layout_set"
        UNION
        SELECT mlwh_sample.description AS "root_sample_id", mlwh_lh_sample.plate_barcode AS "plate_barcode",
        mlwh_sample.phenotype AS "phenotype", mlwh_lh_sample.coordinate AS "coordinate", mlwh_sample.created AS "created",
        "Beckman" as "robot_type"
        FROM #{mlwh_wh_db}.sample as mlwh_sample
        JOIN #{mlwh_wh_db}.lighthouse_sample AS mlwh_lh_sample ON (mlwh_sample.uuid_sample_lims = mlwh_lh_sample.lh_sample_uuid)
        JOIN #{event_wh_db}.subjects AS mlwh_events_subjects ON (mlwh_events_subjects.uuid = UNHEX(REPLACE(mlwh_lh_sample.lh_sample_uuid, '-', '')))
        JOIN #{event_wh_db}.roles AS mlwh_events_roles ON (mlwh_events_roles.subject_id = mlwh_events_subjects.id)
        JOIN #{event_wh_db}.events AS mlwh_events_events ON (mlwh_events_events.id = mlwh_events_roles.event_id)
        JOIN #{event_wh_db}.event_types AS mlwh_events_event_types ON (mlwh_events_event_types.id = mlwh_events_events.event_type_id)
        WHERE mlwh_events_event_types.key = "lh_beckman_cp_destination_created"
      SQL
      security: 'DEFINER'
    )
  end
end
