class AddPrelimIdToStudy < ActiveRecord::Migration
  def change
    change_table :study do |t|
      t.string   'prelim_id',    limit: 5,  comment: 'Prelim Id'
    end
  end
end
