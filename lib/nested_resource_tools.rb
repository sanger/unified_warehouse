module NestedResourceTools

  extend ActiveSupport::Concern

  def latest(other)
    yield(self) if ( other.last_updated > last_updated )
  end

  module ClassMethods

    def create_or_update(attributes)

      attributes = Array.convert(attributes)

      new_atts  = attributes.map{ |a| a.reverse_merge(:data => attributes)}

      base_resource = attributes.first

      lims      = base_resource.id_lims
      id_x_lims = base_resource["id_#{name.underscore}_lims"]

      for_lims(lims).with_id(id_x_lims).tap do |all_records|
        all_records.first.latest(base_resource) do |record|
          all_records.destroy_all
          return create!(new_atts) unless base_resource.deleted?
        end
      end

    end
    private :create_or_update
  end
end
