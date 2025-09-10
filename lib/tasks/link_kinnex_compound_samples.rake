# frozen_string_literal: true

namespace :psd_sample_compounds_components do
  desc 'Link compound Kinnex samples to their components in the database'

  task link_kinnex_compound_samples: :environment do
    Rails.logger.info 'Linking compound Kinnex samples to their components in the database'
    kinnex_supplier_names.each do |supplier_name|
      # Select compound samples where accession_number is nil (unaccessioned)
      compound_sample = Sample.where(name: supplier_name, accession_number: nil)
      # Skip if there are multiple compound samples for the same supplier name
      # Realistically, this should never happen — we expect only one source of truth for each supplier_name.
      next if compound_sample.empty? || compound_sample.many?

      #  Select component samples where accession_number is present (accessioned)
      component_samples = Sample.where(supplier_name: supplier_name).where.not(accession_number: nil)
      Rails.logger.debug { "Linking compound sample #{compound_sample.first.id_sample_tmp} to component sample #{component_samples.pluck(:id_sample_tmp).join(', ')}" }
      component_samples.each do |component_sample|
        SampleCompoundComponent.find_or_create_by!(
          compound_id_sample_tmp: compound_sample.first.id_sample_tmp,
          component_id_sample_tmp: component_sample.id_sample_tmp
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
       SP14a SP14b SP14c SP14d]
  end
end
