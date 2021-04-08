# frozen_string_literal: true

# Add most of the fields from Sequencescape sample_metadata table that aren't already here
# To avoid having to fulfil individual requests for fields to be copied over
class AddSampleFields < ActiveRecord::Migration[6.0]
  def change
    add_column :sample, :sibling, :string
    add_column :sample, :is_resubmitted, :boolean
    add_column :sample, :date_of_sample_collection, :string
    add_column :sample, :date_of_sample_extraction, :string
    add_column :sample, :extraction_method, :string
    add_column :sample, :purified, :string
    add_column :sample, :purification_method, :string
    add_column :sample, :customer_measured_concentration, :string
    add_column :sample, :concentration_determined_by, :string
    add_column :sample, :sample_type, :string
    add_column :sample, :storage_conditions, :string
    add_column :sample, :genotype, :string
    add_column :sample, :age, :string
    add_column :sample, :cell_type, :string
    add_column :sample, :disease_state, :string
    add_column :sample, :compound, :string
    add_column :sample, :dose, :string
    add_column :sample, :immunoprecipitate, :string
    add_column :sample, :growth_condition, :string
    add_column :sample, :organism_part, :string
    add_column :sample, :time_point, :string
    add_column :sample, :disease, :string
    add_column :sample, :subject, :string
    add_column :sample, :treatment, :string
    add_column :sample, :date_of_consent_withdrawn, :datetime
    add_column :sample, :marked_as_consent_withdrawn_by, :string
  end
end
