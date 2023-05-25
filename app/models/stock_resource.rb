# StockResource
class StockResource < ApplicationRecord
  include ResourceTools
  include CompositeResourceTools

  has_associated(:study)
  has_associated(:sample)

  has_composition_keys(:id_stock_resource_lims, :id_sample_tmp)

  json do
    translate(
      stock_resource_id: :id_stock_resource_lims,
      uuid: :stock_resource_uuid,
      machine_barcode: :labware_machine_barcode,
      human_barcode: :labware_human_barcode
    )

    has_nested_model(:samples)

    ignore(:samples)
  end
end
