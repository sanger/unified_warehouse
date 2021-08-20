class AddCurrentRnaIdToLighthouseSample < ActiveRecord::Migration[6.0]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.string :current_rna_id, null: true, default: nil, comment: 'Current rna_id value for this sample'
      t.boolean :is_current, null: false, default: false, comment: 'Identifies if this sample has the most up to date information for the same rna_id'

      t.index %i[current_rna_id], unique: true # same uniqueness criteria as in MongoDB
      t.index %i[is_current], unique: false # same uniqueness criteria as in MongoDB
    end
  end
end
