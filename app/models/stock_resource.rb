class StockResource < ActiveRecord::Base
  include ResourceTools
  include SingularResourceTools

  has_associated(:study)
  has_associated(:sample)

  json do

    translate(
      :stock_resource_id => :id_stock_resource_lims,
      :uuid              => :stock_resource_uuid
    )

  end

end
