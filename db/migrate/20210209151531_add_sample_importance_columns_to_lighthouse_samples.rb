# frozen_string_literal: true

# Adds the two sample importance columns to the lighthouse_sample table
class AddSampleImportanceColumnsToLighthouseSamples < ActiveRecord::Migration[6.0]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.boolean :must_sequence,           null: true, comment: 'PAM provided value whether sample is of high importance'
      t.boolean :preferentially_sequence, null: true, comment: 'PAM provided value whether sample is important'
    end
  end
end
