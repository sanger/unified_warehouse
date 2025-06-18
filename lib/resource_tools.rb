module ResourceTools
  require 'resource_tools/core_extensions'

  extend ActiveSupport::Concern
  include ResourceTools::Json
  include ResourceTools::Association
  include ResourceTools::Timestamps

  included do |base|
    # scope :updating, lambda { |r| where(:uuid => r.uuid).current }

    # The original data information is stored here
    attr_accessor :data

    # Before saving store whether this is a new record.  This allows us to determine whether we have inserted a new
    # row, which we use in the checks of whether the AmqpConsumer is working: if the ApiConsumer inserts a row then
    # we're probably not capturing all of the right messages.
    before_save :remember_if_we_are_a_new_record

    scope :for_lims,  ->(lims) { where(id_lims: lims) }
    scope :with_uuid, ->(uuid) { where("uuid_#{base.name.underscore}_lims": uuid) }
    # IDs can be alphanumerics, so the column is not set to integer. While MySQL is smart enough to handle the conversion, it
    # slows down the queries significantly (~400ms vs 2). Ruby handles the conversion much more quickly.
    scope :with_id,   ->(id) {   where(base.base_resource_key => id.to_s) }

    def self.base_resource_key
      "id_#{name.underscore}_lims"
    end
  end

  def inserted_record?
    @inserted_record
  end

  def related
    self.class.for_uuid(uuid)
  end

  # Has this record been deleted remotely
  def deleted?
    deleted_at.present?
  end

  # Delete the record
  def delete!
    dup.tap do |record|
      record.uuid = uuid
      record.deleted_at = Time.now
      record.recorded_at = record.last_updated = record.deleted_at
      record.save!
    end
  end

  IGNOREABLE_ATTRIBUTES = %w[dont_use_id recorded_at].freeze

  def updated_values?(object)
    us = attributes.stringify_keys
    them = object.attributes.stringify_keys.reverse_slice(IGNOREABLE_ATTRIBUTES)
    !us.within_acceptable_bounds?(them)
  end

  private

  def remember_if_we_are_a_new_record
    @inserted_record = new_record?
  end

  class InvalidMessage < StandardError
  end
end
