# frozen_string_literal: true

# OseqFlowcellRun
class OseqFlowcellRun < ApplicationRecord
  self.table_name = 'oseq_flowcell'

  include ResourceTools
  include NestedResourceTools

  def self.base_resource_key
    'experiment_name'
  end

  has_associated(:study)
  has_associated(:sample)

  json do
    ignore(
      :flowcells
    )

    has_nested_model(:flowcells) do
      ignore(
        :samples
      )

      has_nested_model(:samples)
    end
  end
end
