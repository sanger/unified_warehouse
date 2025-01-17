# frozen_string_literal: true

# Aliquot model
# This model is used to store aliquot data
class Aliquot < ApplicationRecord
  include ResourceTools
  include SingularResourceVersionedTools

  def self.base_resource_key
    'aliquot_uuid'
  end

  json do
    translate(
      uuid: :aliquot_uuid
    )

    ignore :created
  end
end
