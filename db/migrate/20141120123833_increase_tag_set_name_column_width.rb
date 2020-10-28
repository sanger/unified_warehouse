class IncreaseTagSetNameColumnWidth < ActiveRecord::Migration
  def up
    change_table :iseq_flowcell do |t|
      t.change 'tag_set_name',     :string, limit: 100, comment: 'WTSI-wide tag set name'
    end
  end

  def down
    change_table :iseq_flowcell do |t|
      t.change 'tag_set_name', :string, limit: 50, comment: 'WTSI-wide tag set name'
    end
  end
end
