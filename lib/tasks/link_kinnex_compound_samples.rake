# frozen_string_literal: true

namespace :psd_sample_compounds_components do
  desc 'Link compound Kinnex samples to their components in the database'

  task link_kinnex_compound_samples: :environment do
    kinnex_supplier_names.each do |supplier_name|
      # Select compound samples (with accession_number present) to ensure we only get compound samples
      compound_sample = Sample.where(name: supplier_name, id_lims: 'Traction').where.not(accession_number: nil)
      puts "Processing compound_sample: #{compound_sample}"
      # Skip if there are multiple compound samples for the same supplier name
      # Realistically, this should never happen — we expect only one source of truth.
      next if compound_sample.many?

      # Select component samples (with accession_number nil) to ensure we only get component samples
      component_samples = Sample.where(supplier_name: supplier_name, accession_number: nil)
      Rails.logger.debug { "Linking compound sample #{compound_sample.first.id} to component sample #{component_samples.pluck(:id).join(', ')}" }

      component_samples.each do |component_sample|
        SampleCompoundComponent.find_or_create_by!(
          compound_id_sample_tmp: compound_sample.first.id,
          component_id_sample_tmp: component_sample.id
        )
      end
    end
  end

  # Returns distinct supplier names associated with Traction samples
  def kinnex_supplier_names
    Sample.where(supplier_name: Sample.select(:name).where(id_lims: 'Traction')).distinct.pluck(:supplier_name)
  end
end
