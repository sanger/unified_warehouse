class AddPhenotypeColumnToSampleTable < ActiveRecord::Migration
  def change
    change_table :sample do |t|
      t.string   'phenotype', comment: 'The phenotype of the sample as described in Sequencescape'
    end
  end
end
