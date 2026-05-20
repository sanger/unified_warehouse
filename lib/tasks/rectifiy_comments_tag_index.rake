# frozen_string_literal: true

# Incorrect tag indices were being propagated to the MLWH because the initial
# implementation of this feature matched aliquots from the PCR XP plate to pool
# aliquots using `tag.map_id`.
#
# The correct approach is to match aliquots using `sample_id`, `tag1`, `tag2`,
# and `tag_depth`, and then retrieve the relevant `aliquot_index_value` from
# the matching aliquot within the pool.
#
# This issue has now been corrected within Sequencescape. However, the existing
# incorrect data in the MLWH also needed to be rectified.
#
# The related research story is Y26-154.

namespace :comments do
  desc 'Rectify tag_index'

  task rectify_tag_indexes: :environment do
    comment_to_rectify = Struct.new(:batch_id, :position, :tag_index, :correct_tag_index, :comment_type)

    comments_with_wrong_tags = [
      comment_to_rectify.new(batch_id: 107_111, position: 4, tag_index: 9, correct_tag_index: 26, comment_type: 'under_represented'),
      comment_to_rectify.new(batch_id: 107_111, position: 4, tag_index: 82, correct_tag_index: 246, comment_type: 'under_represented'),
      comment_to_rectify.new(batch_id: 107_848, position: 6, tag_index: 41, correct_tag_index: 81, comment_type: 'under_represented'),
      comment_to_rectify.new(batch_id: 107_940, position: 1, tag_index: 44, correct_tag_index: 88, comment_type: 'under_represented')
    ]

    comments_with_wrong_tags.each do |comment|
      existing_comment = Comment.find_by(
        batch_id: comment.batch_id,
        position: comment.position,
        tag_index: comment.tag_index,
        comment_type: comment.comment_type
      )
      if existing_comment
        existing_comment.update!(tag_index: comment.correct_tag_index)
        puts "Updated comment #{existing_comment.id} with tag #{existing_comment.tag_index}"
      else
        puts "Comment not found for batch_id: #{comment.batch_id}, position: #{comment.position}, tag_index: #{comment.tag_index}"
      end
    end
  end
end
