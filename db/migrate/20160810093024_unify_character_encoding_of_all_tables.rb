class UnifyCharacterEncodingOfAllTables < ActiveRecord::Migration
  # SQL provided by David Harper

  def up
    psd_only = ENV.fetch('PSD_ONLY', nil)
    say 'Updating PSD tables only' if psd_only

    say 'Updating database defaults'
    ActiveRecord::Base.connection.execute("ALTER DATABASE CHARACTER SET = 'utf8'  COLLATE = 'utf8_unicode_ci';")
    say 'Updating flgen_plate'
    ActiveRecord::Base.connection.execute("ALTER TABLE `flgen_plate` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    say 'Updating iseq_flowcell'
    ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_flowcell` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    say 'Updating pac_bio_run'
    ActiveRecord::Base.connection.execute("ALTER TABLE `pac_bio_run` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    say 'Updating sample'
    ActiveRecord::Base.connection.execute("ALTER TABLE `sample` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    say 'Updating schema_migrations'
    ActiveRecord::Base.connection.execute("ALTER TABLE `schema_migrations` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    say 'Updating study'
    ActiveRecord::Base.connection.execute("ALTER TABLE `study` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    say 'Updating study_users'
    ActiveRecord::Base.connection.execute("ALTER TABLE `study_users` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")

    unless psd_only
      say 'Updating non psd tables'
      say 'Updating iseq_product_metrics', true
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_product_metrics` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
      say 'Updating iseq_run_lane_metrics', true
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_run_lane_metrics` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
      say 'Updating iseq_run_status', true
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_run_status` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
      say 'Updating iseq_run_status_dict', true
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_run_status_dict` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
    end
  end

  def down
    psd_only = ENV.fetch('PSD_ONLY', nil)
    say 'Restoring PSD tables only' if psd_only

    say 'Restoring database defaults'
    ActiveRecord::Base.connection.execute("ALTER DATABASE CHARACTER SET = 'latin1'  COLLATE = 'latin1_swedish_ci';")

    say 'Restoring flgen_plate'
    ActiveRecord::Base.connection.execute("ALTER TABLE `flgen_plate` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
    say 'Restoring iseq_flowcell'
    ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_flowcell` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
    say 'Restoring pac_bio_run'
    ActiveRecord::Base.connection.execute("ALTER TABLE `pac_bio_run` CONVERT TO CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';")
    say 'Restoring sample'
    ActiveRecord::Base.connection.execute("ALTER TABLE `sample` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
    say 'Restoring schema_migrations'
    ActiveRecord::Base.connection.execute("ALTER TABLE `schema_migrations` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
    say 'Restoring study'
    ActiveRecord::Base.connection.execute("ALTER TABLE `study` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
    say 'Restoring study_users'
    ActiveRecord::Base.connection.execute("ALTER TABLE `study_users` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")

    unless psd_only
      say 'Restoring non psd tables'
      say 'Restoring iseq_product_metrics'
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_product_metrics` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
      say 'Restoring iseq_run_lane_metrics'
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_run_lane_metrics` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
      say 'Restoring iseq_run_status'
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_run_status` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
      say 'Restoring iseq_run_status_dict'
      ActiveRecord::Base.connection.execute("ALTER TABLE `iseq_run_status_dict` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';")
    end
  end
end
