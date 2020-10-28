# frozen_string_literal: true

# A Sample extraction activity is generated in the Sample extraction Lims
# when an activity is finished.
class SamplesExtractionActivity < ApplicationRecord
  include ResourceTools
  include NestedResourceTools

  self.table_name = 'samples_extraction_activity'

  def self.base_resource_key
    'id_activity_lims'
  end

  has_associated(:sample)

  json do
    has_nested_model(:samples) do
    end

    ignore(
      :samples
    )

    translate(
      activity_id: :id_activity_lims
    )
  end
end
