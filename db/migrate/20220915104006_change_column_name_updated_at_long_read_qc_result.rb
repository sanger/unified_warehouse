# frozen_string_literal: true

# Modified column name to last_updated to suit the message from rabbitmq
class ChangeColumnNameUpdatedAtLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    rename_column :long_read_qc_result, :updated_at, :last_updated
  end
end
