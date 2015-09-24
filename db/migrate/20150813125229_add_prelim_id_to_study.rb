class AddPrelimIdToStudy < ActiveRecord::Migration
  def change
    change_table :study do |t|
      t.string   'prelim_id', limit: 20,  comment: 'The preliminary study id prior to entry into the LIMS'
    end
  end
end
