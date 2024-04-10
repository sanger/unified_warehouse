# frozen_string_literal: true

# Aliquot model
# This model is used to store aliquot data
class Aliquot < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  def self.base_resource_key
    'id'
  end

  json do
    translate(
      uuid: :id
    )
  end
end
