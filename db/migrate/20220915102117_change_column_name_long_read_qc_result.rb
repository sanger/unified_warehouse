# frozen_string_literal: true

# Modified column name to created to suit the message from rabbitmq
class ChangeColumnNameLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    rename_column :long_read_qc_result, :created_at, :created
  end
end
