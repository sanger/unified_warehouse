# frozen_string_literal: true

# Add id_lims
class AddIdLimsToLongReadQcResult < ActiveRecord::Migration[6.0]
  def change
    add_column :long_read_qc_result, :id_lims, :string
  end
end
