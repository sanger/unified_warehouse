# frozen_string_literal: true

# This module is used to store the latest version of a record and manage versioned records.
# It provides methods to check if a record is the latest and if any attributes have changed,
# and to create or update records accordingly. This ensures an audit trail of updates by
# creating new records when necessary.
module SingularResourceVersionedTools
  extend ActiveSupport::Concern

  # Checks if the attributes of the given record have changed and if the given record is more recent.
  # If both conditions are met, yields the given record for further processing.
  #
  # @param other [ActiveRecord::Base] The record to compare with.
  # @yield [ActiveRecord::Base] Yields the given record if it is the latest and has changed.
  # @return [ActiveRecord::Base] Returns the current record if the given record is not the latest or has not changed.
  def latest(other)
    attributes_changed?(other) && (other.last_updated > last_updated) ? yield(other) : self
  end

  # Compares the attributes of the current record with the given record, excluding 'id', 'created_at', and 'updated_at'.
  #
  # @param other [ActiveRecord::Base] The record to compare with.
  # @return [Boolean] Returns true if the attributes have changed, false otherwise.
  def attributes_changed?(other)
    attributes.except('id', 'created_at', 'last_updated', 'recorded_at') != other.attributes.except('id', 'created_at', 'last_updated', 'recorded_at')
  end

  # This module is used to create or update a record
  module ClassMethods
    # Creates or updates a record based on the given attributes.
    # If an existing record with the same base resource key is found, it checks if the new record is the latest
    # and if any attributes have changed. If both conditions are met, it creates a new record to maintain an audit trail.
    # Otherwise, it updates the existing record.
    #
    # @param attributes [Hash] The attributes of the record to create or update.
    # @return [ActiveRecord::Base] Returns the created or updated record.
    def create_or_update(attributes)
      new_record = new(attributes.to_hash)

      # byebug
      existing_record = for_lims(attributes.id_lims).with_id(attributes[base_resource_key]).order(last_updated: :desc)
                                                    .first

      # byebug
      if existing_record.nil?
        # byebug
        # No existing record found, save the new record
        new_record.save!
      else
        existing_record.latest(new_record) do |record|
          # byebug
          record.update(attributes.to_hash) if record.present?
          record ||= new_record
          record.save!
        end
      end
    end
    private :create_or_update
  end
end
