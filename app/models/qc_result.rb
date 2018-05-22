class QcResult < ActiveRecord::Base
  include ResourceTools
  include NestedResourceTools

  has_associated(:sample)

  json do
    has_nested_model(:aliquots)
    ignore(:aliquots)
  end
end
