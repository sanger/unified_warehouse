class AddHdmcNumberToStudiesTable < ActiveRecord::Migration
  def change
    change_table :study do |t|
      t.string   'hmdmc_number', comment: 'The Human Materials and Data Management Committee approval number(s) for the study.'
    end
  end
end
