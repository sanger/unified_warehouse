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

    # IDs can be alphanumerics, so the column is not set to integer. While MySQL is smart enough to handle the conversion, it
    # slows down the queries significantly (~400ms vs 2). Ruby handles the conversion much more quickly.
    scope :for_lims,  lambda { |lims| where(id_lims: lims) }
    scope :with_uuid, lambda { |uuid| where(:"uuid_#{base.name.underscore}_lims" => uuid)}
    scope :with_id,   lambda { |id|   where(base.base_resource_key => id.to_s) }

    def self.base_resource_key
      "id_#{name.underscore}_lims"
    end
  end

  def remember_if_we_are_a_new_record
    @inserted_record = new_record?
    true
  end
  private :remember_if_we_are_a_new_record

  def inserted_record?
    @inserted_record
  end

  def related
    self.class.for_uuid(self.uuid)
  end

  # Has this record been deleted remotely
  def deleted?
    deleted_at.present?
  end

  # Delete the record
  def delete!
    dup.tap do |record|
      record.uuid, record.deleted_at = self.uuid, Time.now
      record.recorded_at = record.last_updated = record.deleted_at
      record.save!
    end
  end

  IGNOREABLE_ATTRIBUTES = ['dont_use_id', 'recorded_at']

  def updated_values?(object)
    us, them = self.attributes.stringify_keys, object.attributes.stringify_keys.reverse_slice(IGNOREABLE_ATTRIBUTES)
    not us.within_acceptable_bounds?(them)
  end
end
