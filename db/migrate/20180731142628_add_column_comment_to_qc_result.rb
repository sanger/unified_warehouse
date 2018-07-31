class AddColumnCommentToQcResult < ActiveRecord::Migration
  def change
    set_column_comment :qc_result, :last_updated, "The date the qc_result was last updated in SS"
  end
end
