class Flowcell < ActiveRecord::Base
  include ResourceTools
  include NestedResourceTools

  self.table_name = 'iseq_flowcell'

  has_associated(:study)
  has_associated(:sample)

  json do

    has_nested_model(:lanes) do

      # has_own_record

      translate(
        :id_pool_lims => :entity_id_lims
      )

      ignore(
        :samples,
        :controls
      )

      custom_value(:num_target_components) do
        (controls||[]).count + (samples||[]).count
      end

      custom_value(:is_spiked) do
        controls.present? && controls.count > 0
      end

      has_nested_model(:controls) do
      end

      has_nested_model(:samples) do
      end

    end

    ignore(
      :lanes
    )

    translate(
      :flowcell_id => :id_flowcell_lims
    )
  end

end
