# frozen_string_literal: true

# This model is used to store the information about Ultima Genomics wafers.
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
    'id_wafer_lims'
  end

  has_associated(:study)  # association using id_study_tmp foreign key
  has_associated(:sample) # association using id_sample_tmp foreign key

  # We expand the wafer message into multiple rows. The following keys are
  # used to identify the rows.
  has_composition_keys(
    :id_wafer_lims,
    :lane,
    :tag_sequence
  )

  json do
    has_nested_model(:lanes) do # The message has nested lanes section.
      ignore(:samples) # This key is for the nested section; not mapped to a column.
      has_nested_model(:samples) # The message has nested samples section.
    end

    ignore(:lanes) # This key is for the nested section; not mapped to a column.

    translate(wafer_id: :id_wafer_lims)
  end
end
