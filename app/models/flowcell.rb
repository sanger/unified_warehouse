class Flowcell < ApplicationRecord
  include ResourceTools
  include CompositeResourceTools

  self.table_name = 'iseq_flowcell'

  has_associated(:study)
  has_associated(:sample)

  has_composition_keys(:tag_index, :id_flowcell_lims, :entity_id_lims, :entity_type, :position, :tag_sequence, :tag2_sequence)

  json do
    has_nested_model(:lanes) do
      ignore(
        :samples,
        :controls
      )

      custom_value(:is_spiked) do
        controls.present? && controls.count > 0
      end

      has_nested_model(:controls)
      has_nested_model(:samples)
    end

    ignore(
      :lanes
    )

    translate(
      flowcell_id: :id_flowcell_lims
    )
  end
end
