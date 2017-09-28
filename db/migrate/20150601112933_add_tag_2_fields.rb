class AddTag2Fields < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.string   'tag2_sequence',    limit: 30,  comment: 'Tag sequence for tag 2', after: :tag_set_name
      t.string   'tag2_set_id_lims', limit: 20,  comment: 'LIMs-specific identifier of the tag set for tag 2', after: :tag2_sequence
      t.string   'tag2_set_name',    limit: 100, comment: 'WTSI-wide tag set name for tag 2', after: :tag2_set_id_lims
    end
  end
end
