# frozen_string_literal: true

# Include in an ActiveRecord::Base object to handle JSON parsing and translation.
#
# @example Including a basic parser
#   class MyClass < ApplicationRecord
#     include ResourceTools
#
#     json do
#       translate(
#         side_walk: :pavement,
#         trunk: :boot
#       )
#     end
#   end
#
# The example above will create a new subclass of `ResourceTools::Json::Handler`
# called `MyClass::JsonHandler`. This can be accessed via the class method
# {ResourceTools::Json::json}
#
# The JsonHandler will automatically take parsed json (ie. covered to a Hash)
# and will:
# - convert each key to a string
# - perform any translations specified via {ResourceTools::Json::Handler::translate}
#
# @example Invoking the Handler
#   MyClass.create_or_update_from_json(parsed_json, 'Lims')
#
# This will extract the translated attributes from parsed_json and pass them
# into the create_or_update method.
module ResourceTools::Json
  extend ActiveSupport::Concern

  module ClassMethods
    #
    # Translates the provided json_data with the appropriate
    # {ResourceTools::Json::Handler} and passes into create_or_update
    #
    # @param json_data [Hash] parse JSON data
    # @param lims [String] Identifier for the originating lims
    #
    # @return [ApplicationRecord] An Active Record object built from the provided json
    #
    def create_or_update_from_json(json_data, lims)
      ActiveRecord::Base.transaction do
        create_or_update(json.collection_from(json_data, lims))
      end
    end

    def json(&block)
      const_set(:JsonHandler, Class.new(ResourceTools::Json::Handler)) unless const_defined?(:JsonHandler)
      const_get(:JsonHandler).tap { |json_handler| json_handler.instance_eval(&block) if block }
    end
    private :json
  end

  # @todo Consider switch to ActiveSupport::HashWithIndifferentAccess
  # We've remove our Hashie::Mash dependency in the event warehouse, where
  # ActiveSupport::HashWithIndifferentAccess was a near drop-in replacement.
  # Here however we have additional use of converting method calls into key
  # lookups. It should be possible to replace these with explicit method
  # definitions, but this fell outside the scope of a simple refactor.
  class Handler < Hashie::Mash
    class_attribute :translations
    self.translations = {}

    class_attribute :ignoreable
    self.ignoreable = []

    class_attribute :stored_as_boolean
    self.stored_as_boolean = []

    class_attribute :nested_models
    self.nested_models = {}

    class_attribute :recorded
    self.recorded = false

    class_attribute :custom_values
    self.custom_values = nil

    class << self
      # Hashes in subkeys might as well be normal Hashie::Mash instances as we don't want to bleed
      # the key conversion further into the data.
      def subkey_class
        Hashie::Mash
      end

      def has_nested_model(name, &block)
        self.nested_models = ({}) if nested_models.blank?
        const_set(:"#{name.to_s.classify}JsonHandler", Class.new(ResourceTools::Json::Handler))
        nested_models[name] = const_get(:"#{name.to_s.classify}JsonHandler")
        nested_models[name].tap { |json_handler| json_handler.instance_eval(&block) if block }
      end

      def ignore(*attributes)
        self.ignoreable += attributes.map(&:to_s)
      end

      def store_as_boolean(*attributes)
        self.stored_as_boolean += attributes.map(&:to_s)
      end

      # JSON attributes can be translated into the attributes on the way in.
      def translate(details)
        self.translations = details.stringify_keys
                                   .transform_values(&:to_s)
                                   .reverse_merge(translations)
      end

      def convert_key(key)
        translations[key.to_s] || key.to_s
      end

      def collection_from(json_data, lims)
        # We're not nested, so just return the standard json
        return new(json_data.reverse_merge(id_lims: lims)) if nested_models.blank?

        [].tap do |collection|
          original = new(json_data.reverse_merge(id_lims: lims))
          collection << original if recorded
          each_nested_model(json_data) do |nested, handler|
            collection << handler.collection_from(original.reverse_merge(nested), lims)
          end
        end.flatten
      end

      def each_nested_model(json_data)
        nested_models.each do |name, handler|
          next if json_data[name.to_s].nil?

          json_data[name.to_s].each do |nested|
            yield(nested, handler)
          end
        end
      end
      private :each_nested_model

      def has_own_record
        self.recorded = true
      end

      def custom_value(name, &block)
        self.custom_values = ({}) if custom_values.blank?
        custom_values[name] = block
      end
    end

    def initialize(*args, &block)
      super
      if self.class.custom_values.present?
        self.class.custom_values.each do |k, block|
          self[k] = instance_eval(&block)
        end
      end
      convert_booleans
      delete_if { |k, _| ignoreable.include?(k) }
    end

    def convert_booleans
      self.stored_as_boolean.each do |key|
        self[key] = self[key].to_boolean_from_arguments if has_key?(key)
      end
    end
    private :convert_booleans

    def deleted?
      deleted_at.present?
    end

    delegate :convert_key, to: 'self.class'

    translate(updated_at: :last_updated, created_at: :created)
  end
end
