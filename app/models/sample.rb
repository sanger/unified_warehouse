# Samples received from each of the LIMS systems. These may also be compound samples
# which represent other component samples as a set that have been pooled together.
class Sample < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  # Set up directional many-to-many associations from this Sample to compound Samples.
  # This indicates that this Sample is a component in a pool of other component Samples represented by each compound Sample.
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

  attr_accessor :component_sample_uuids

  before_validation :link_component_samples

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

  private

  def link_component_samples
    tags = component_tags_from_json # Sample => tag_sequence

    wanted_ids = tags.keys(&:id_sample_tmp)
    links = joins_as_compound_sample.index_by(&:component_id_sample_tmp)

    links.each do |component_id, link|
      joins_as_compound_sample.destroy(link) unless wanted_ids.include?(component_id)
    end

    tags.each do |component, tag_sequence|
      link = links[component.id_sample_tmp]
      if link
        link.update!(tag_sequence: tag_sequence) unless link.tag_sequence == tag_sequence
      else
        joins_as_compound_sample.build(component_sample: component, tag_sequence: tag_sequence)
      end
    end
  end

  def component_tags_from_json
    (component_sample_uuids || []).to_h do |entry|
      key = component_sample_for(entry['uuid_sample_lims'])
      [key, entry['tag_sequence']]
    end
  end

  def component_sample_for(uuid)
    Sample.with_uuid(uuid).first || raise(ActiveRecord::RecordNotFound, "No sample with uuid '#{uuid}'")
  end
end
