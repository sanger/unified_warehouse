# frozen_string_literal: true
# Index to query long_read_qc_results using assay_type_key
class AddIndexLongReadQcResultsAssayTypeKey < ActiveRecord::Migration[7.0]
  def change
    add_index :long_read_qc_result, :assay_type_key, unique: false
  end
end
