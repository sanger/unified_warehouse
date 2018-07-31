class RenameDateUpdatedToLastUpdatedInQcResult < ActiveRecord::Migration
  def change
    rename_column :qc_result, :date_updated, :last_updated
  end
end
