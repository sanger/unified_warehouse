# frozen_string_literal: true

# Add a join table to allow samples to be compounds made up of component samples.
class AddSampleCompoundsComponentsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_compounds_components do |t|
      t.integer :compound_sample_id, null: false
      t.integer :component_sample_id, null: false

      t.datetime :last_updated, null: false, comment: 'Timestamp of last update'
      t.datetime :recorded_at, null: false, comment: 'Timestamp of warehouse update'
    end
  end
end
