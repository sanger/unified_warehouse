class UpdateIseqFlowcellColumns < ActiveRecord::Migration
  def change
    change_table :iseq_flowcell do |t|
      t.integer "legacy_library_id", comment: 'Legacy library_id for backwards compatibility.'
      t.string  "id_library_lims",   comment: 'Earliest LIMs identifier associated with library creation'
    end
  end
end
