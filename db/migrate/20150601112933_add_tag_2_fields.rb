class AddTag2Fields < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.integer  'tag_2_index',                   comment: 'Tag 2 index, NULL if there is no second tag'
      t.string   'tag_2_sequence',    limit: 30,  comment: 'Tag sequence for tag 2'
      t.string   'tag_2_set_id_lims', limit: 20,  comment: 'LIMs-specific identifier of the tag set for tag 2'
      t.string   'tag_2_set_name',    limit: 100, comment: 'WTSI-wide tag set name for tag 2'
    end
  end
end
