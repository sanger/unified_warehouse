# frozen_string_literal: true

namespace :psd_sample_compounds_components do
  desc 'Link compound Kinnex samples to their components in the database'

  task link_kinnex_compound_samples: :environment do
    kinnex_supplier_names.each do |supplier_name|
      # Select compound samples ()where accession_number is nil) (unaccessioned)
      compound_sample = Sample.where(name: supplier_name, id_lims: 'Traction', accession_number: nil)
      puts "Processing compound_sample: #{compound_sample}"
      # Skip if there are multiple compound samples for the same supplier name
      # Realistically, this should never happen — we expect only one source of truth.
      next if compound_sample.many?

      #  Select component samples where accession_number is present (accessioned)
      component_samples = Sample.where(supplier_name: supplier_name).where.not(accession_number: nil)
      Rails.logger.debug { "Linking compound sample #{compound_sample.first.id} to component sample #{component_samples.pluck(:id).join(', ')}" }

      component_samples.each do |component_sample|
        SampleCompoundComponent.find_or_create_by!(
          compound_id_sample_tmp: compound_sample.first.id,
          component_id_sample_tmp: component_sample.id
        )
      end
    end
  end

  # Returns the list of Kinnex supplier names to process
  def kinnex_supplier_names
    %w[SP09a SP09b SP09c
       SP10a SP10b
       SP11a SP11b SP11c SP11d SP11e SP11f
       SP12a
       SP13a SP13b SP13c
       SP14a SP14b SP14c P14d]
  end
end
