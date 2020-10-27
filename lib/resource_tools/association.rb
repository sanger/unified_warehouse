module ResourceTools::Association
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def has_associated(association)
      self.instance_eval %Q{
        belongs_to :#{association}, :foreign_key => :id_#{association}_tmp, required: false
        attr_accessor :#{association}_id, :#{association}_uuid

        before_validation do
          uuid_error = "No #{association} with uuid '%s'"
          id_error   = "No #{association} for '%s' with_id '%s'"

          associate = #{association.to_s.classify}.with_uuid(#{association}_uuid).first or
            raise(ActiveRecord::RecordNotFound, uuid_error % #{association}_uuid) unless #{association}_uuid.blank?
          associate ||= #{association.to_s.classify}.for_lims(id_lims).with_id(#{association}_id).first or
            raise(ActiveRecord::RecordNotFound, id_error % [id_lims,#{association}_id]) unless #{association}_id.blank?
          self.#{association}= associate unless associate.nil?
        end

      }
    end
  end
end
