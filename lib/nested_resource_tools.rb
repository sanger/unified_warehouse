module NestedResourceTools

  extend ActiveSupport::Concern

  def latest(other)
    yield(self) if ( other.last_updated > last_updated )
  end

  module ClassMethods

    def create_or_update(attributes)

      attributes = Array.convert(attributes)

      base_resource = attributes.first

      lims      = base_resource.id_lims
      id_x_lims = base_resource["id_#{name.underscore}_lims"]

      all_records = for_lims(lims).with_id(id_x_lims)

      all_records.first.latest(base_resource) do |record|
        if @composition_keys.present?
          key_attributes = Hash[attributes.map {|a| [composite_key_for(a),a.to_hash] }]
          all_records.each do |old_record|
            new_record = key_attributes.delete(composite_key_for(old_record))
            new_record.present? && ! base_resource.deleted? ? old_record.update_attributes!(new_record) : old_record.delete
          end
          create!(key_attributes.values)unless base_resource.deleted?
        else
          new_atts  = attributes.map{ |a| a.to_hash }
          all_records.destroy_all
          return create!(new_atts) unless base_resource.deleted?
        end
      end


    end
    private :create_or_update

    # Composition keys are those that define the identity of each individual element of a nested resource
    # In the event that keys match 1 to 1, it is possible to perform an update, rather than a destroy
    def has_composition_keys(*keys)
      @composition_keys = keys
    end
    private :has_composition_keys

    def composite_key_for(record)
      @composition_keys.map {|k| record.send(k) }
    end
    private :composite_key_for
  end
end
