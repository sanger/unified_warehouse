# frozen_string_literal: true

# These fields need to be added to support multiplexing
# TODO: confirm with NPG which fields they need
class AddFieldsToOseqFlowcell < ActiveRecord::Migration[6.0]
  def change
    change_table :long_read_qc_result, bulk: true do |t|
      t.string :flowcell_id, comment: 'The id of the flowcell. Supplied with the flowcell. Format FAVnnnn'
    end
  end
end
