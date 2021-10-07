class Sample < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  # Create relationships with samples that contain this Sample via SampleCompoundComponent.
  has_many(
    :joins_as_component_sample,
    foreign_key: :component_sample_id,
    inverse_of: :component_sample,
    class_name: 'SampleCompoundComponent'
  )
  has_many :compound_samples, through: :joins_as_component_sample, source: :compound_sample

  # Create relationships with samples that are contained by this Sample via SampleCompoundComponent.
  # Samples that are contained by this Sample should not themselves contain more Samples.
  # This is validated in the SampleCompoundComponent model.
  has_many(
    :joins_as_compound_sample,
    foreign_key: :compound_sample_id,
    inverse_of: :compound_sample,
    class_name: 'SampleCompoundComponent'
  )
  has_many :component_samples, through: :joins_as_compound_sample, source: :component_sample

  json do
    ignore(
      :new_name_format,
      :sample_manifest_id,
      :sample_tubes,
      :empty_supplier_sample_name,
      :updated_by_manifest
    )

    translate(
      id: :id_sample_lims,
      uuid: :uuid_sample_lims
    )
  end
end
