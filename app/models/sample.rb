class Sample < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  json do
    ignore(
      :new_name_format,
      :sample_manifest_id,
      :sample_tubes,
      :empty_supplier_sample_name,
      :updated_by_manifest
    )

    translate(
      id: :id_sample_lims,
      uuid: :uuid_sample_lims
    )
  end
end
