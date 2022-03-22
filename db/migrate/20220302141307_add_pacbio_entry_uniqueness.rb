# frozen_string_literal: true

# Adds new virtual columns to return -1 when tag_identifier or tag2_identifier is null
class AddPacbioEntryUniqueness < ActiveRecord::Migration[6.0]
  def change
    change_table :pac_bio_run, bulk: true do |table|
      table.virtual :comparable_tag_identifier, type: :string, as: 'IFNULL(tag_identifier, -1)', description: 'It will contain the value of tag_identifier, or -1 if the value was null. This virtual column is intended to support SQL comparisons if needed.'
      table.virtual :comparable_tag2_identifier, type: :string, as: 'IFNULL(tag2_identifier, -1)', description: 'It will contain the value of tag2_identifier, or -1 if the value was null. This virtual column is intended to support SQL comparisons if needed.'
    end
  end
end
