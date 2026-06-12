# StockResource
class StockResource < ApplicationRecord
  include ResourceTools
  include CompositeResourceTools

  has_associated(:study)
  has_associated(:sample)

  has_composition_keys(:id_stock_resource_lims, :id_sample_tmp)

  json do
    translate(
      stock_resource_id: :id_stock_resource_lims,
      uuid: :stock_resource_uuid,
      machine_barcode: :labware_machine_barcode,
      human_barcode: :labware_human_barcode
    )

    has_nested_model(:samples)

    # Ignore nested container key and all internal *_tmp ids from payloads.
    # Internal FKs are derived from UUID lookups, not trusted from messages.
    ignore(
      :samples,
      :id_stock_resource_tmp,
      :id_sample_tmp,
      :id_study_tmp
    )
  end

  # Resolve sample UUID before composition key matching.
  #
  # Overrides the parent {CompositeResourceTools#create_or_update} method
  # to resolve incoming +sample_uuid+ values to their database
  # +id_sample_tmp+ foreign keys before composition key matching occurs.
  # This is necessary because +id_sample_tmp+ is not part of the incoming
  # message but is part of the composition key
  # (+[:id_stock_resource_lims, :id_sample_tmp]+). Without this
  # pre-resolution, update operations would fail to match existing records
  # and would recreate rows instead of updating them in place.
  #
  # The resolution is applied to each attribute object (each sample entry)
  # before the parent's composition matching logic runs, ensuring that
  # composition keys have real values on both incoming and persisted records.
  #
  # @param [Array<Hashie::Mash>, Hashie::Mash] attributes One or more
  #   attribute objects (typically expanded from nested model samples).
  #   Each object is expected to have a +sample_uuid+ field that maps to
  #   an existing {Sample} record.
  #
  # @return [true] Always returns +true+ on success (following parent
  #   method contract). Returns early with +true+ if attributes array is
  #   empty.
  #
  # @raise [ActiveRecord::RecordNotFound] If a +sample_uuid+ does not
  #   resolve to an existing {Sample} record. This exception is intended
  #   for Warren consumer delay handling (transient failures).
  #
  # @example Single sample entry update
  #   attributes = [
  #     {
  #       id_stock_resource_lims: "12345",
  #       sample_uuid: "550e8400-e29b-41d4-a716-446655440000",
  #       study_uuid: "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
  #       current_volume: 5.5
  #     }
  #   ]
  #   StockResource.create_or_update(attributes)
  #   # => true (id_sample_tmp is resolved and populated before matching)
  #
  # @example Multiple sample entries (nested model expansion)
  #   attributes = [
  #     {
  #       id_stock_resource_lims: "12345",
  #       sample_uuid: "uuid-1",
  #       study_uuid: "study-1"
  #     },
  #     {
  #       id_stock_resource_lims: "12345",
  #       sample_uuid: "uuid-2",
  #       study_uuid: "study-2"
  #     }
  #   ]
  #   StockResource.create_or_update(attributes)
  #   # => true (each entry has its sample UUID resolved independently)
  #
  # @note The parent {CompositeResourceTools#create_or_update} method will
  #   still invoke {CompositeResourceTools#has_associated
  #   has_associated(:sample)} callbacks during validation, which will
  #   re-verify and update the FK. This pre-resolution is purely for
  #   composition key matching correctness.
  #
  # @see CompositeResourceTools#create_or_update
  # @see CompositeResourceTools#composite_key_for
  def self.create_or_update(attributes)
    attributes = Array.convert(attributes)
    return true if attributes.empty?

    attributes.each do |attr|
      resolve_sample_association(attr) if attr.sample_uuid.present?
    end

    super
  end

  # Resolve a sample UUID to its database foreign key ID.
  #
  # Looks up the {Sample} record matching the given UUID and populates the
  # attribute object's +id_sample_tmp+ field with the database-assigned value.
  # This field is used as part of the composition key but is ignored during
  # JSON parsing, so it must be restored before composition key matching.
  #
  # @param [Hashie::Mash] attr The attribute object (typically from expanding
  #   nested model samples). Must have a +sample_uuid+ field.
  #
  # @return [void] Mutates +attr+ in place by setting +id_sample_tmp+.
  #
  # @raise [ActiveRecord::RecordNotFound] If no {Sample} exists with the
  #   provided +sample_uuid+.
  #
  # @example
  #   attr = { sample_uuid: "550e8400-e29b-41d4-a716-446655440000" }
  #   resolve_sample_association(attr)
  #   attr.id_sample_tmp  # => 1096 (database value for that sample)
  #
  # @see Sample.with_uuid
  def self.resolve_sample_association(attr)
    sample = Sample.with_uuid(attr.sample_uuid).first
    raise ActiveRecord::RecordNotFound, "No sample with uuid '#{attr.sample_uuid}'" if sample.nil?

    attr.id_sample_tmp = sample.id_sample_tmp
  end

  private_class_method :resolve_sample_association
end
