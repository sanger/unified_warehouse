module CompositeResourceTools
  class InvalidMessage < StandardError; end

  extend ActiveSupport::Concern

  def latest(other)
    yield(self) if other.last_updated > last_updated
  end

  module ClassMethods
    private

    def create_or_update(attributes)
      attributes = Array.convert(attributes)
      return true if attributes.empty?

      base_resource = attributes.first

      lims      = base_resource.id_lims
      id_x_lims = base_resource[base_resource_key]

      all_records = for_lims(lims).with_id(id_x_lims)

      all_records.first.latest(base_resource) do |_record|
        key_attributes = Hash[attributes.map { |a| [composite_key_for(a), a.to_hash] }]

        # If the hash length is different from the original attributes length, then our composite key
        # is not unique. Reject the message so that the problem can be addressed.
        invalid_message! if key_attributes.length != attributes.length

        all_records.each do |old_record|
          new_record = key_attributes.delete(composite_key_for(old_record))
          new_record.present? && !base_resource.deleted? ? old_record.update!(new_record) : old_record.destroy
        end
        return create!(key_attributes.values) unless base_resource.deleted?
      end
    end

    # Composition keys are those that define the identity of each individual element of a nested resource
    # In the event that keys match 1 to 1, it is possible to perform an update, rather than a destroy
    def has_composition_keys(*keys)
      @composition_keys = keys
    end

    def composite_key_for(record)
      @composition_keys.map { |k| record.send(k).to_s }
    end

    def invalid_message!
      raise InvalidMessage, "Contains two elements with the same composite identifier: combination of #{@composition_keys.join(', ')} should be unique."
    end
  end
end
