# frozen_string_literal: true

# Increasing the sample accession_number to match sequencescape db length due to larger entries required
class IncreaseSampleAccessionNumberLength < ActiveRecord::Migration[6.1]
  def up
    change_table :sample do |t|
      t.change 'accession_number', :string
    end
  end

  def down
    change_table :sample do |t|
      t.change 'accession_number', :string, limit: 50
    end
  end
end
