class FlgenPlate < ActiveRecord::Base

  include ResourceTools
  include NestedResourceTools

  has_associated(:study)
  has_associated(:sample)

  self.table_name = 'flgen_plate'

  json do
    has_nested_model(:wells) do
      has_own_record
    end

    ignore(
      :wells
    )

  end

end
