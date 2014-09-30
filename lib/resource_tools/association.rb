module ResourceTools::Association

  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def has_associated(association)
      self.instance_eval %Q{
        belongs_to :#{association}
        attr_accessor :#{association}_id, :#{association}_uuid

        before_validation do
          associate = #{association.to_s.classify}.with_uuid(#{association}_uuid).first unless #{association}_uuid.blank?
          associate ||= #{association.to_s.classify}.for_lims(id_lims).with_id(#{association}_id).first unless #{association}_id.blank?
          self.#{association}= associate unless associate.blank?
        end

      }
    end

  end
end
