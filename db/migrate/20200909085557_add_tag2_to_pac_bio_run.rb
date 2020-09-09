# frozen_string_literal: true

# Add tag2 information to the pac_bio_run table so we can do dual indexing
class AddTag2ToPacBioRun < ActiveRecord::Migration
  def change
    change_table :pac_bio_run, bulk: true do |t|
      t.string   'tag2_sequence',    limit: 30,  comment: 'Tag sequence for tag 2', after: :tag_set_name
      t.string   'tag2_set_id_lims', limit: 20,  comment: 'LIMs-specific identifier of the tag set for tag 2', after: :tag2_sequence
      t.string   'tag2_set_name',    limit: 100, comment: 'WTSI-wide tag set name for tag 2', after: :tag2_set_id_lims
      t.string   'tag2_identifier', limit: 30, comment: 'The position of tag2 within the tag group', after: :tag2_set_name
    end
  end
end
