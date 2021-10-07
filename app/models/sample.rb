class Sample < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  # Create relationships with samples that contain this Sample via SampleCompoundComponent.
  has_many(
    :joins_as_component_sample,
    class_name: 'SampleCompoundComponent',
    dependent: :destroy,
    foreign_key: :component_sample_id,
    inverse_of: :component_sample
  )
  has_many(
    :compound_samples,
    source: :compound_sample,
    through: :joins_as_component_sample
  )

  # Create relationships with samples that are contained by this Sample via SampleCompoundComponent.
  has_many(
    :joins_as_compound_sample,
    class_name: 'SampleCompoundComponent',
    dependent: :destroy,
    foreign_key: :compound_sample_id,
    inverse_of: :compound_sample
  )
  has_many(
    :component_samples,
    source: :component_sample,
    through: :joins_as_compound_sample
  )

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
