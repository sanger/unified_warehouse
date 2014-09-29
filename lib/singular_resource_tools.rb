module SingularResourceTools

  extend ActiveSupport::Concern

  def latest(other)
    yield(self) if updated_values?(other) && ( other.last_updated > last_updated )
  end

  module ClassMethods
    def create_or_update(attributes)
      new_atts = attributes.reverse_merge(:data => attributes)
      for_lims(attributes.id_lims).with_id(new_atts["id_#{name.underscore}_lims"]).first.latest(new(new_atts)) do |record|
        record.update_attributes(new_atts)
        record.save!
      end
    end
    private :create_or_update
  end
end
