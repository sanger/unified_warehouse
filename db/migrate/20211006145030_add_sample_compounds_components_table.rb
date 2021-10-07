# frozen_string_literal: true

# Add a join table to allow samples to be compounds made up of component samples.
class AddSampleCompoundsComponentsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :psd_sample_compounds_components, comment: 'A join table owned by PSD to associate compound samples with their component samples.' do |t|
      t.integer :compound_id_sample_tmp, null: false, comment: 'The warehouse ID of the compound sample in the association.'
      t.integer :component_id_sample_tmp, null: false, comment: 'The warehouse ID of the component sample in the association.'

      t.datetime :last_updated, null: false, comment: 'Timestamp of last update.'
      t.datetime :recorded_at, null: false, comment: 'Timestamp of warehouse update.'
    end
  end
end
