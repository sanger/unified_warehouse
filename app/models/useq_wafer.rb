# frozen_string_literal: true

# This model is used to store the information about Ultima Genomics wafers.
# It is similar to the Illumina flowcell model, but the useq_wafer table
# contains only a subset of the columns of the iseq_flowcell table and is named
# differently to reflect the Ultima Genomics instrument using wafers instead of flowcells.
# It also tracks additional information required for lot number tracking.
class UseqWafer < ApplicationRecord
  include ResourceTools # Tools for mapping messages to the database.
  include CompositeResourceTools # Tools for handling nested structures.

  self.table_name = 'useq_wafer'

  # Used for identifying the base resource. This field is in the top level of
  # the message. This is a LIMS-specific unique identifier for the wafer;
  # it is a batch_id for Sequencescape.
  # NOTE: The actual wafers have identifiers etched onto them, but we do not track them
  # and we do not want to confuse them with the LIMs-specific identifiers.
  def self.base_resource_key
    'id_batch_lims'
  end

  has_associated(:study)  # association using id_study_tmp foreign key
  has_associated(:sample) # association using id_sample_tmp foreign key

  # We expand the wafer message into multiple rows. The following keys are
  # used to identify the rows.
  has_composition_keys(
    :id_batch_lims,
    :lane,
    :tag_sequence
  )

  json do # rubocop:disable Metrics/BlockLength
    has_nested_model(:lanes) do # The message has nested lanes section.
      ignore(:samples, :controls) # These keys are not mapped to columns.

      has_nested_model(:samples)  # The message has nested samples section.
      has_nested_model(:controls) # The message has nested controls section.
    end

    ignore(:lanes) # This key is for the nested section; not mapped to a column.

    # TODO
    # The following fields are included in the Iseq flowcell mesage. We assume
    # the same message for useq wafer as well until the Sequencescape side of
    # the messaging is implemented. However, we need to ignore the fields that
    # are not mapped to the columns of the useq_wafer table.
    ignore(
      :manual_qc,
      :priority,
      :external_release,
      :purpose,
      :spiked_phix_barcode,
      :spiked_phix_percentage,
      :workflow,
      :loading_concentration,
      :flowcell_barcode,
      :forward_read_length,
      :reverse_read_length,
      :tag_set_id_lims,
      :tag_set_name,
      :tag_identifier,
      :tag2_sequence,
      :tag2_set_id_lims,
      :tag2_set_name,
      :tag2_identifier,
      :cost_code,
      :is_r_and_d,
      :tag_index,
      :team,
      :suboptimal,
      :legacy_library_id
    )

    # We translate the fields from the message to the columns of the table.
    # Note that the 'position' column of the iseq_flowcell table is named as
    # 'lane' in the useq_wafer table. If the mapping is done on the
    # Sequencescape side, we need to update the translation accordingly.
    translate(flowcell_id: :id_batch_lims, position: :lane)
  end
end
