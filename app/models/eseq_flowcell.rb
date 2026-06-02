# frozen_string_literal: true

# This model is used to store the information about Element Aviti flowcells.
# It is similar to the Illumina flowcell model, but the eseq_flowcell table
# contains only a subset of the columns of the iseq_flowcell table.
class EseqFlowcell < ApplicationRecord
  include ResourceTools # Tools for mapping messages to the database.
  include CompositeResourceTools # Tools for handling nested structures.

  self.table_name = 'eseq_flowcell'

  # Used for identifying the base resource. This field is in the top level of
  # the message. This is a LIMS-specific unique identifier for the flowcell;
  # it is a batch_id for Sequencescape.
  def self.base_resource_key
    'id_flowcell_lims'
  end

  has_associated(:study)  # association using id_study_tmp foreign key
  has_associated(:sample) # association using id_sample_tmp foreign key

  # We expand the flowcell message into multiple rows. The following keys are
  # used to identify the rows.
  has_composition_keys(
    :id_flowcell_lims,
    :lane,
    :tag_sequence,
    :tag2_sequence
  )

  json do
    has_nested_model(:lanes) do # The message has nested lanes section.
      ignore(:samples, :controls) # These keys are not mapped to columns.

      has_nested_model(:samples)  # The message has nested samples section.
      has_nested_model(:controls) # The message has nested controls section.
    end

    ignore(:lanes) # This key is for the nested section; not mapped to a column.

    # We translate the fields from the message to the columns of the table.
    translate(flowcell_id: :id_flowcell_lims)
  end
end
