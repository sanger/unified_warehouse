# frozen_string_literal: true

# Adds an index on the QC Result table for id library lims
class AddIndexForIdLibraryLimsToQcResultTable < ActiveRecord::Migration
  def change
    add_index :qc_result, :id_library_lims, name: :qc_result_id_library_lims_index
  end
end
