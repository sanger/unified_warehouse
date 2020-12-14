module SingularResourceTools
  extend ActiveSupport::Concern

  def latest(other)
    updated_values?(other) && (other.last_updated > last_updated) ? yield(self) : self
  end

  module ClassMethods
    def create_or_update(attributes)
      new_record = new(attributes.to_hash)
      for_lims(attributes.id_lims).with_id(attributes[base_resource_key]).first.latest(new_record) do |record|
        record.update(attributes.to_hash) if record.present?
        record ||= new_record
        record.save!
      end
    end
    private :create_or_update
  end
end
