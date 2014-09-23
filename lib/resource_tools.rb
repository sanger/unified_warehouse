module ResourceTools
  require 'resource_tools/core_extensions'

  extend ActiveSupport::Concern
  include ResourceTools::Json
  include ResourceTools::Timestamps

  included do |base|

    # scope :updating, lambda { |r| where(:uuid => r.uuid).current }

    # The original data information is stored here
    attr_accessor :data

    # Before saving store whether this is a new record.  This allows us to determine whether we have inserted a new
    # row, which we use in the checks of whether the AmqpConsumer is working: if the ApiConsumer inserts a row then
    # we're probably not capturing all of the right messages.
    before_save :remember_if_we_are_a_new_record

    scope :for_lims, lambda { |lims| where(:id_lims=>lims) }
    scope :with_id,  lambda { |id|   where(:"id_#{base.table_name}_lims"=>id) }
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

  IGNOREABLE_ATTRIBUTES = [ 'dont_use_id', 'recorded_at']

  def updated_values?(object)
    us, them = self.attributes.stringify_keys, object.attributes.stringify_keys.reverse_slice(IGNOREABLE_ATTRIBUTES)
    not us.within_acceptable_bounds?(them)
  end

  # def checked!
  #   self.save!
  #   self
  # end

  # def check(object)
  #   updated_values?(object) ? yield : checked!
  # end

  def latest(other)
    yield(self) if updated_values?(other) && ( other.last_updated > last_updated )
  end

  module ClassMethods
    def create_or_update(attributes,lims)
      new_atts = attributes.reverse_merge(:data => attributes,:id_lims=>lims)
      for_lims(lims).with_id(new_atts["id_#{table_name}_lims"]).first.latest(new(new_atts)) do |record|
        record.update_attributes(new_atts)
        record.save!
      end
    end
    private :create_or_update
  end
end
