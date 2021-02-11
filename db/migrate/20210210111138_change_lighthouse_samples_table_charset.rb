# frozen_string_literal: true
#
# Change charset of lighthouse_sample to use utf8 instead of latin1
#
class ChangeLighthouseSamplesTableCharset < ActiveRecord::Migration[6.0]
  def up
    ActiveRecord::Base.connection.execute("ALTER TABLE `lighthouse_sample` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';")
  end

  def down
    ActiveRecord::Base.connection.execute("ALTER TABLE `lighthouse_sample` CONVERT TO CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';")
  end
end
