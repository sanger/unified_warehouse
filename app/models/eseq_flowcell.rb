# frozen_string_literal: true

class EseqFlowcell < ApplicationRecord
  include ResourceTools
  include CompositeResourceTools

  self.table_name = 'eseq_flowcell'

  def self.base_resource_key
    'id_flowcell_lims'
  end

  has_associated(:study)
  has_associated(:sample)

  json do
    translate(
      flowcell_id: :id_flowcell_lims
    )
  end
end
