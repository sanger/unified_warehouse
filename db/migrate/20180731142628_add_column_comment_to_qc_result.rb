class AddColumnCommentToQcResult < ActiveRecord::Migration
  def change
    change_column_comment :qc_result, :last_updated, from: nil, to: 'The date the qc_result was last updated in SS'
  end
end
