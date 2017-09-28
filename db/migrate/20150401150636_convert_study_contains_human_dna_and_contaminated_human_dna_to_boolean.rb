class ConvertStudyContainsHumanDnaAndContaminatedHumanDnaToBoolean < ActiveRecord::Migration
  def up
    change_table :study do |t|
      t.change :contains_human_dna,     :boolean, comment: 'Lane may contain human DNA'
      t.change :contaminated_human_dna, :boolean, comment: 'Human DNA in the lane is a contaminant and should be removed'
    end
  end

  def down
    change_table :study do |t|
      t.change :contains_human_dna,     :string
      t.change :contaminated_human_dna, :string
    end
  end
end
