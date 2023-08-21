# frozen_string_literal: true

# Change encoding of long_read_qc_result table
class ChangeEncodingLongReadQcResults < ActiveRecord::Migration[7.0]
  def self.up
    ActiveRecord::Base.connection
    execute "ALTER TABLE `long_read_qc_result` CONVERT TO CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';"
  end
end
