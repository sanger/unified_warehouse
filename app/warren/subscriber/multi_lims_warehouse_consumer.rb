# frozen_string_literal: true

require './lib/payload'
module Warren
  module Subscriber
    # Warren powered MultiLimsWarehouseConsumer consumers
    # Default consumer for the warehouse
    # Takes messages from the psd.mlwh.production queue
    #
    # Messages are diverse, and vary depending on the record type:
    #
    # == Example Sample
    # {
    #   "sample": {
    #     "uuid": "1a205a1a-c199-11e0-96e9-00144f206e2e",
    #     "id": 1255142,
    #     "name": "test_study_a1",
    #     "new_name_format": true,
    #     "created_at": "2011-08-08T09:33:32+01:00",
    #     "updated_at": "2021-05-18T13:27:37+01:00",
    #     "sanger_sample_id": null,
    #     "control": null,
    #     "control_type": null,
    #     "sample_manifest_id": null,
    #     "empty_supplier_sample_name": false,
    #     "updated_by_manifest": false,
    #     "consent_withdrawn": false,
    #     "organism": null,
    #     "cohort": null,
    #     "country_of_origin": null,
    #     "geographical_region": null,
    #     "ethnicity": null,
    #     "customer_measured_volume": null,
    #     "mother": null,
    #     "father": null,
    #     "replicate": null,
    #     "gc_content": "Neutral",
    #     "gender": null,
    #     "dna_source": "Genomic",
    #     "public_name": "Test",
    #     "common_name": "Felis catus",
    #     "strain": null,
    #     "taxon_id": 9685,
    #     "accession_number": "ERS044816",
    #     "description": null,
    #     "sample_visibility": "Hold",
    #     "developmental_stage": null,
    #     "supplier_name": null,
    #     "donor_id": null,
    #     "phenotype": null,
    #     "sibling": null,
    #     "is_resubmitted": null,
    #     "date_of_sample_collection": null,
    #     "date_of_sample_extraction": null,
    #     "extraction_method": null,
    #     "purified": null,
    #     "purification_method": null,
    #     "customer_measured_concentration": null,
    #     "concentration_determined_by": null,
    #     "sample_type": null,
    #     "storage_conditions": null,
    #     "genotype": null,
    #     "age": null,
    #     "cell_type": null,
    #     "disease_state": null,
    #     "compound": null,
    #     "dose": null,
    #     "immunoprecipitate": null,
    #     "growth_condition": null,
    #     "organism_part": null,
    #     "time_point": null,
    #     "disease": null,
    #     "subject": null,
    #     "treatment": null,
    #     "date_of_consent_withdrawn": "2021-05-18T13:27:37+01:00",
    #     "marked_as_consent_withdrawn_by": "jg16",
    #     "reference_genome": "Not suitable for alignment"
    #   },
    #   "lims": "SQSCP_ST"
    # }
    #
    # == More examples
    #
    # For more examples, see the corresponding spec files.
    class MultiLimsWarehouseConsumer < Warren::Subscriber::Base
      # == Handling messages
      # Message processing is handled in the {#process} method. The following
      # methods will be useful:
      #
      # @!attribute [r] payload
      #   @return [String] the payload of the message
      # @!attribute [r] delivery_info
      #   @return [Bunny::DeliveryInfo] mostly used internally for nack/acking messages
      #                                 http://rubybunny.info/articles/queues.html#accessing_message_properties_metadata
      # @!attribute [r] properties
      #   @return [Bunny::MessageProperties] additional message properties.
      #                             http://rubybunny.info/articles/queues.html#accessing_message_properties_metadata

      # Handles message processing. Messages are acknowledged automatically
      # on return from the method assuming they haven't been handled already.
      # In the event of an uncaught exception, the message will be dead-lettered.
      def process
        # Handle message processing here. Additionally you have the following options:
        # dead_letter(exception) => Dead Letters the message
        # requeue(exception) => Sends a nack, which causes the message to be placed back on the queue
        logger.info("Payload received: #{payload}")
        Payload.from_json(payload).record
        # A message is sent to the delayed queue when the record is not found. This is useful when the record
        # is not yet created or has been deleted. The message will be retried later with a TTL policy.
      rescue ActiveRecord::RecordNotFound => e
        delay(e)
      # When the association type is mismatched, we want to dead letter the message because it is unlikely
      # that the message would be processed correctly in the future. ActiveRecord::AssociationTypeMismatch
      # is raised when an object assigned to an association has an incorrect type. This is the same for
      # an InvalidMessage, which is raised when the message does not conform to the expected JSON format.
      #
      # It is better to have schema validations at both the client and server side to ensure that
      # messages are correctly formatted and contain the expected data. That is probably for the future.
      rescue ActiveRecord::AssociationTypeMismatch, Payload::InvalidMessage => e
        dead_letter(e)
      end
    end
  end
end
