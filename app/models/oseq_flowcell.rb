class OseqFlowcell < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  def self.base_resource_key
    'id_flowcell_lims'
  end

  has_associated(:study)
  has_associated(:sample)

  json do
    translate(
      flowcell_id: :id_flowcell_lims
    )

    ignore :created, :created_at, :uuid
  end
end
