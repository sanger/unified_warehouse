# frozen_string_literal: true

# Add most of the fields from Sequencescape sample_metadata table that aren't already here
# To avoid having to fulfil individual requests for fields to be copied over
# rubocop:disable Metrics/BlockLength, Metrics/MethodLength
class AddSampleFields < ActiveRecord::Migration[6.0]
  def up
    change_table :sample, bulk: true do |t|
      t.string :sibling, null: true
      t.boolean :is_resubmitted, null: true
      t.string :date_of_sample_collection, null: true
      t.string :date_of_sample_extraction, null: true
      t.string :extraction_method, null: true
      t.string :purified, null: true
      t.string :purification_method, null: true
      t.string :customer_measured_concentration, null: true
      t.string :concentration_determined_by, null: true
      t.string :sample_type, null: true
      t.string :storage_conditions, null: true
      t.string :genotype, null: true
      t.string :age, null: true
      t.string :cell_type, null: true
      t.string :disease_state, null: true
      t.string :compound, null: true
      t.string :dose, null: true
      t.string :immunoprecipitate, null: true
      t.string :growth_condition, null: true
      t.string :organism_part, null: true
      t.string :time_point, null: true
      t.string :disease, null: true
      t.string :subject, null: true
      t.string :treatment, null: true
      t.datetime :date_of_consent_withdrawn, null: true
      t.string :marked_as_consent_withdrawn_by, null: true
      t.string :customer_measured_volume, null: true
      t.string :gc_content, null: true
      t.string :dna_source, null: true
    end
  end

  def down
    change_table :sample, bulk: true do |t|
      t.remove :sibling
      t.remove :is_resubmitted
      t.remove :date_of_sample_collection
      t.remove :date_of_sample_extraction
      t.remove :extraction_method
      t.remove :purified
      t.remove :purification_method
      t.remove :customer_measured_concentration
      t.remove :concentration_determined_by
      t.remove :sample_type
      t.remove :storage_conditions
      t.remove :genotype
      t.remove :age
      t.remove :cell_type
      t.remove :disease_state
      t.remove :compound
      t.remove :dose
      t.remove :immunoprecipitate
      t.remove :growth_condition
      t.remove :organism_part
      t.remove :time_point
      t.remove :disease
      t.remove :subject
      t.remove :treatment
      t.remove :date_of_consent_withdrawn
      t.remove :marked_as_consent_withdrawn_by
      t.remove :customer_measured_volume
      t.remove :gc_content
      t.remove :dna_source
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/MethodLength
