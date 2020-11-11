class QcResult < ApplicationRecord
  include ResourceTools
  include NestedResourceTools

  has_associated(:sample)

  json do
    has_nested_model(:aliquots)
    ignore(:aliquots)

    # Remove this after sequencescape has been deployed
    translate(
      date_updated: :last_updated
    )
  end
end
