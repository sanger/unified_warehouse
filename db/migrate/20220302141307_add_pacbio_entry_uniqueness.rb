# frozen_string_literal: true

class AddPacbioEntryUniqueness < ActiveRecord::Migration[6.0]
  def change
    change_table :pac_bio_run do |table|
      table.virtual :comparable_tag_identifier, type: :integer, as: 'IFNULL(tag_identifier, -1)', description: 'It will contain the value of tag_identifier, or -1 if the value was null. This virtual column is intended to support SQL comparisons if needed.'
      table.virtual :comparable_tag2_identifier, type: :integer, as: 'IFNULL(tag2_identifier, -1)', description: 'It will contain the value of tag2_identifier, or -1 if the value was null. This virtual column is intended to support SQL comparisons if needed.'
    end
  end
end
