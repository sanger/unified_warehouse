# Each message received from the producer (for example CommentIo on SS) may contain
# multiple comments nested under a single batch resource.
# Because of this, the consumer uses a nested model definition
# (`has_nested_model(:comments)`) to correctly interpret and
# extract multiple comment records from the serialized message.
#
# The `ignore(:comments)` directive ensures that the top-level
# wrapper key (`"comments"`) is not treated as a database attribute,
# allowing the nested comment entries to be processed individually.
#
# This setup allows messages of the form:
#
# ```json
# {
#   "comment": {
#     "comments": [
#       {
#         "comment_type": "under_represented",
#         "comment_value": "true",
#         "last_updated": "2024-05-01T12:34:56Z",
#         "batch_id": 123,
#         "position": 1,
#         "tag_index": 2
#       },
#       ...
#     ]
#   }
# }

class Comment < ApplicationRecord
  include ResourceTools
  include CompositeResourceTools

  self.table_name = 'comments'
  def self.base_resource_key
    'batch_id'
  end

  has_composition_keys(
    :batch_id,
    :position,
    :tag_index,
    :comment_type,
    :comment_value
  )

  json do
    has_nested_model(:comments)
    ignore(
      :comments
    )
  end
end
