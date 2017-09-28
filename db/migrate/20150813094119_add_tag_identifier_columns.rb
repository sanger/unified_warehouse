class AddTagIdentifierColumns < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.string   'tag_identifier',  limit: 30,  comment: 'The position of tag within the tag group',  after: :tag_set_name
      t.string   'tag2_identifier', limit: 30,  comment: 'The position of tag2 within the tag group', after: :tag2_set_name
    end
  end
end
