# Provides behaviour to allow records to be associated with multiple users with different roles.
# For example, the association of owners, managers etc. with a Study, as presented in the
# study_users table
module AssociatedWithRoles
  def self.extended(base)
    base.class_eval do
      include InstanceMethods

      has_role(:manager)
      has_role(:follower)
      has_role(:owner)
      has_role(:administrator)

      user_model = Class.new(ActiveRecord::Base) { include AssociatedWithRoles::User }
      user_model.associated_with(base)
      const_set(:User, user_model)
      after_save :maintain_users
    end
  end

  def has_role(name)
    define_method(:"#{name}=") { |users| set_users(name, users) }
  end

  module InstanceMethods
    def users_to_maintain
      @users ||= Hash.new { |h, k| h[k] = [] }
    end
    private :users_to_maintain

    def set_users(role, user_details)
      users_to_maintain[role.to_s] = user_details
    end
    private :set_users

    def users
      self.class::User.owned_by(self)
    end

    def maintain_users # rubocop:disable Naming/PredicateMethod
      users.destroy_all

      users.create!(
        users_to_maintain.map do |role, user_details|
          user_details.map do |details|
            details.reverse_merge(role: role.to_s, associated_id: id, last_updated:)
          end
        end
      )

      true
    end
    private :maintain_users
  end

  module User
    extend ActiveSupport::Concern

    included do |base|
      base.pluralize_table_names = true
    end

    module ClassMethods
      def associated_with(model)
        association_name = model.name.underscore
        alias_attribute(:associated_id, "id_#{association_name}_tmp")

        scope :owned_by, ->(record) { where("id_#{association_name}_tmp" => record.id) }
      end
    end
  end
end
