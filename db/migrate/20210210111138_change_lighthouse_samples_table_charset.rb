class ChangeLighthouseSamplesTableCharset < ActiveRecord::Migration[6.0]
  def up
    ActiveRecord::Base.connection.execute("ALTER TABLE `lighthouse_sample` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
  end

  def down
    ActiveRecord::Base.connection.execute("ALTER TABLE `lighthouse_sample` CONVERT TO CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';")
  end
end
