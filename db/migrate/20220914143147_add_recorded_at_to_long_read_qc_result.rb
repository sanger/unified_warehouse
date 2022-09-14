# frozen_string_literal: true

# Added recorded_at column
class AddRecordedAtToLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    add_column :long_read_qc_result, :recorded_at, :datetime
  end
end
