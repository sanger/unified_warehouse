class Comment < ApplicationRecord
  include ResourceTools
  include NestedResourceTools

  self.table_name = 'comments'
  def self.base_resource_key
    'id'
  end

  json do
    has_nested_model(:comments)
    ignore(
      :comments
    )
  end
end
