# frozen_string_literal: true

class Aliquot < ApplicationRecord
  include ResourceTools
  include SingularResourceTools

  def self.base_resource_key
    'id_lims'
  end

end
