class Sample < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  # Set up directional many-to-many associations from this Sample to compound Samples.
  # This indicates that this Sample is a component in a pool of other Samples respresented by the compound Sample.
  has_many(
    :joins_as_component_sample,
    class_name: 'SampleCompoundComponent',
    dependent: :destroy,
    foreign_key: :component_id_sample_tmp,
    inverse_of: :component_sample
  )
  has_many :compound_samples, through: :joins_as_component_sample

  # Set up directional many-to-many associations from this Sample to component Samples.
  # This indicates that this Sample represents a pool of those component Samples.
  has_many(
    :joins_as_compound_sample,
    class_name: 'SampleCompoundComponent',
    dependent: :destroy,
    foreign_key: :compound_id_sample_tmp,
    inverse_of: :compound_sample
  )
  has_many :component_samples, through: :joins_as_compound_sample

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
