# frozen_string_literal: true

# Adds uniqueness constraint check on run, well, tag and tag2
class AddUniquePacbioEntryIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :pac_bio_run,
              %i[id_lims id_pac_bio_run_lims well_label comparable_tag_identifier comparable_tag2_identifier],
              unique: true, name: 'unique_pac_bio_entry'
  end
end
