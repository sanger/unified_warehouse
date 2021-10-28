# frozen_string_literal: true

#
# A {SampleCompoundComponent} is a join object for samples, creating a relationship
# useful for pooling samples in such a way that the compound sample represents a larger
# number of component samples in receptacles.
class SampleCompoundComponent < ApplicationRecord
  self.table_name = 'psd_sample_compounds_components'

  belongs_to(
    :compound_sample,
    class_name: 'Sample',
    foreign_key: :compound_id_sample_tmp,
    inverse_of: :joins_as_compound_sample
  )
  belongs_to(
    :component_sample,
    class_name: 'Sample',
    foreign_key: :component_id_sample_tmp,
    inverse_of: :joins_as_component_sample
  )

  def self.timestamp_attributes_for_create
    super << 'recorded_at'
  end

  def self.timestamp_attributes_for_update
    super << 'last_updated'
  end
end
