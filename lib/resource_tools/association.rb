module ResourceTools::Association
  extend ActiveSupport::Concern

  private

  def choose_associated_uuid_record(candidates, association_name)
    return nil if candidates.nil?

    # Prefer current study rows when duplicate UUIDs exist (studies only).
    if association_name.to_sym == :study && candidates.many?
      current_scope = candidates.where(is_current: true)
      candidates = current_scope if current_scope.exists?
    end

    candidates.last
  end

  module ClassMethods
    def has_associated(association)
      belongs_to association, foreign_key: "id_#{association}_tmp", optional: true
      attr_accessor "#{association}_id", "#{association}_uuid"

      before_validation do
        uuid_error = "No #{association} with uuid '%s'"
        id_error   = "No #{association} for '%s' with_id '%s'"
        association_class = association.to_s.classify.constantize

        # Access the association UUID and ID from the instance variables
        # which are set by the attr_accessor defined above.
        association_uuid = public_send("#{association}_uuid")
        association_id = public_send("#{association}_id")

        associate = nil

        # Check UUID first when both UUID and ID are provided
        if association_uuid.present?
          associate = choose_associated_uuid_record(association_class.with_uuid(association_uuid), association)
          # If uuid was provided but no record was found, raise an error.
          raise(ActiveRecord::RecordNotFound, uuid_error % association_uuid) if associate.nil?
        end

        # If no UUID was provided, try to find the association by ID if provided.
        if associate.nil? && association_id.present?
          associate = association_class.for_lims(id_lims).with_id(association_id).first
          # If id was provided but no record was found, raise an error.
          raise(ActiveRecord::RecordNotFound, format(id_error, id_lims, association_id)) if associate.nil?
        end

        # If an associated record was found, assign it to the association.
        public_send("#{association}=", associate) unless associate.nil?
      end
    end
  end
end
