# frozen_string_literal: true

# Add index on sample id for long read qc results to be able to join with samples
class AddIndexLongReadQcResultsSampleId < ActiveRecord::Migration[7.0]
  def change
    add_index :long_read_qc_results, :sample_id, unique: false
  end
end
