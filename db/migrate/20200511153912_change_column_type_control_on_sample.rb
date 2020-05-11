class ChangeColumnTypeControlOnSample < ActiveRecord::Migration
  CONTROL_DATA_MAPPING_UP = {
    '0' => 'no_control',
    '1' => 'control'
  }

  CONTROL_DATA_MAPPING_DOWN = {
    'no_control' => '0',
    'control' => '1',
    'positive_control' => '1', # there shouldn't be any of these, but if there are then they should map to control rather than not control
    'negative_control' => '1' # there shouldn't be any of these, but if there are then they should map to control rather than not control
  }

  def up
    puts "Changing column type from boolean to string..."
    change_column :sample, :control, :string

    puts "Migrating data..."
    ActiveRecord::Base.transaction do
      Sample.all.each do |sample|
        sample.update!(control: CONTROL_DATA_MAPPING_UP[sample.control])
      end
    end

    puts "Done"
  end

  def down
    puts "Migrating data back..."
    ActiveRecord::Base.transaction do
      Sample.all.each do |sample|
        sample.update!(control: CONTROL_DATA_MAPPING_DOWN[sample.control])
      end
    end

    puts "Reverting column type from string to boolean..."
    change_column :sample, :control, :boolean

    puts "Done"
  end
end
