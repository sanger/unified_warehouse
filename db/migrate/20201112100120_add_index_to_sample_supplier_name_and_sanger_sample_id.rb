# frozen_string_literal: true

# Addresses Issue#139
# Indexes added to improved query performance for end users
class AddIndexToSampleSupplierNameAndSangerSampleId < ActiveRecord::Migration[6.0]
  def change
    change_table :sample, bulk: true do |t|
      t.index :supplier_name
      t.index :sanger_sample_id
    end
  end
end
