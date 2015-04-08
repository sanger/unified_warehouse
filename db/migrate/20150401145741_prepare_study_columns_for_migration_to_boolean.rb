class PrepareStudyColumnsForMigrationToBoolean < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      fields_to_convert.each do |field|
        say "Updating #{field}..."
        Study.where(field => 'Yes').update_all(field=>1)
        Study.where(field => 'No').update_all(field=>0)
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      fields_to_convert.each do |field|
        say "Reverting #{field}..."
        Study.where(field => '1').update_all(field=>'Yes')
        Study.where(field => '0').update_all(field=>'No')
      end
    end
  end

  def fields_to_convert
    [
      :contains_human_dna,
      :contaminated_human_dna
    ]
  end
end
