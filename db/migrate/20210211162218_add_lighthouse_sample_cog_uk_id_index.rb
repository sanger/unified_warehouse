class AddLighthouseSampleCogUkIdIndex < ActiveRecord::Migration[6.0]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.index :cog_uk_id
    end
  end
end
