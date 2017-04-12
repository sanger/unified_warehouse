class StockResource < ActiveRecord::Base
  include ResourceTools
  include CompositeResourceTools

  has_associated(:study)
  has_associated(:sample)

  has_composition_keys(:id_stock_resource_lims,:id_sample_tmp)

  json do

    translate(
      :stock_resource_id => :id_stock_resource_lims,
      :uuid              => :stock_resource_uuid
    )

    has_nested_model(:samples) do
    end

    ignore(:samples)

  end

end
