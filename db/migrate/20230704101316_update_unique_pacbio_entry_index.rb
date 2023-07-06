# frozen_string_literal: true

# Updates uniqueness constraint to check on: lims, run, well, tag, tag2 and plate number
class UpdateUniquePacbioEntryIndex < ActiveRecord::Migration[7.0]
  def self.up
    remove_index :pac_bio_run, %i[id_lims id_pac_bio_run_lims well_label comparable_tag_identifier comparable_tag2_identifier]

    add_index :pac_bio_run,
              %i[id_lims id_pac_bio_run_lims well_label comparable_tag_identifier comparable_tag2_identifier plate_number],
              unique: true, name: 'unique_pac_bio_entry'
  end

  def self.down
    remove_index :pac_bio_run, %i[id_lims id_pac_bio_run_lims well_label comparable_tag_identifier comparable_tag2_identifier plate_number]

    add_index :pac_bio_run,
              %i[id_lims id_pac_bio_run_lims well_label comparable_tag_identifier comparable_tag2_identifier],
              unique: true, name: 'unique_pac_bio_entry'
  end
end
