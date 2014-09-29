class Flowcell < ActiveRecord::Base
  include ResourceTools
  include NestedResourceTools

  self.table_name = 'iseq_flowcell'

  json do

    has_nested_model(:lanes) do

      has_own_record

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

      has_nested_model(:controls) do
        ignore(:sample_uuid)
      end

      has_nested_model(:samples) do
        ignore(:sample_uuid,:study_uuid)
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
