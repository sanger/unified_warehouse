# frozen_string_literal: true

# These fields need to be added to support multiplexing
# TODO: confirm with NPG which fields they need
class AddFieldsToOseqFlowcell < ActiveRecord::Migration[6.0]
  def change
    change_table :long_read_qc_result, bulk: true do |t|
      # We need to set this to null false but can't do that until we turn off old traction
      t.string :flowcell_id, comment: 'The id of the flowcell. Supplied with the flowcell. Format FAVnnnn'
      t.string :tag_sequence, limit: 30, comment: 'Tag sequence for tag'
      t.string :tag_set_name, comment: 'WTSI wide tag set name for tag'
      t.string :library_tube_uuid, limit: 36, comment: 'The uuid for the originating library tube'
      t.string :library_tube_barcode, comment: 'The barcode for the originating library tube'
      t.string :run_uuid, limit: 36, comment: 'The uuid of the run'
    end
  end
end
