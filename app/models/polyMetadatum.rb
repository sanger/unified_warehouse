class PolyMetadatum < ApplicationRecord
  include ResourceTools
  include SingularResourceVersionedTools

  self.table_name = 'comments'
  def self.base_resource_key
    'id'
  end
end
