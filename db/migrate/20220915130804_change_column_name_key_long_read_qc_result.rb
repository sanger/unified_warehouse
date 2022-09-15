# frozen_string_literal: true

# Renamed column to avoid ambiguity
class ChangeColumnNameKeyLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    rename_column :long_read_qc_result, :key, :assay_type_key
  end
end
