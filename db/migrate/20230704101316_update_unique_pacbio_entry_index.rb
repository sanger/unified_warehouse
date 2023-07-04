class UpdateUniquePacbioEntryIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :pac_bio_run, name: 'unique_pac_bio_entry'

    add_index :pac_bio_run,
              %i[id_lims id_pac_bio_run_lims well_label comparable_tag_identifier comparable_tag2_identifier plate_number],
              unique: true, name: 'unique_pac_bio_entry'
  end
end
