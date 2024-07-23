# frozen_string_literal: true

# Aliquot model
# This model is used to store aliquot data
class Aliquot < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  def self.base_resource_key
    'id_aliquot_lims'
  end

  json do
    # translate(
    #   uuid: :lims_uuid
    # )

    ignore :created
  end
end
