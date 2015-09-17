class PacBioRun < ActiveRecord::Base
  include ResourceTools
  include NestedResourceTools

  has_associated(:study)
  has_associated(:sample)

  json do

    ignore(
      :wells
    )

    has_nested_model(:wells) do

      ignore(
        :samples
      )

      has_nested_model(:samples) do
      end

    end

    translate(
      :pac_bio_run_id => :id_pac_bio_run_lims
    )
  end



end
