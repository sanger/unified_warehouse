# frozen_string_literal: true
# 
# Migration to add the 'useq_wafer' table to store Ultima Genomics instrument's wafer information
class AddUltimaSeqWaferTable < ActiveRecord::Migration[7.2]
  def change
    create_table :useq_wafer, primary_key: :id_useq_wafer_tmp do |t|
      # Columns required for NPG linkage and basic tracking
      t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
      t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
      t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
      t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
      t.string "id_wafer_lims", limit: 20, null: false, comment: "LIMs-specific wafer id, batch_id for Sequencescape"
      t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE", index: true
      t.integer "lane", limit: 2, null: false, comment: "Wafer lane number", unsigned: true
      t.string "entity_type", limit: 30, null: false, comment: "Lane type: library, library_indexed"
      t.string "tag_sequence", limit: 30, comment: "Tag sequence"
      t.string "pipeline_id_lims", limit: 60, comment: "LIMs-specific pipeline identifier that unambiguously defines library type"
      t.string "bait_name", limit: 50, comment: "WTSI-wide name that uniquely identifies a bait set"
      t.integer "requested_insert_size_from", comment: "Requested insert size min value", unsigned: true
      t.integer "requested_insert_size_to", comment: "Requested insert size max value", unsigned: true
      t.string "ot_recipe", comment: "Opentron recipe name: Flex or Free"
      t.string "primer_panel", comment: "Primer Panel name"
      t.string "id_pool_lims", limit: 20, null: false, comment: "Most specific LIMs identifier associated with the pool", index: true
      t.string "id_library_lims", comment: "Earliest LIMs identifier associated with library creation", index: true
      t.string "entity_id_lims", limit: 20, null: false, comment: "Most specific LIMs identifier associated with this lane or plex or spike"

      # Columns required for lot number tracking
      t.string "otr_carrier_lot_number", comment: "Opentron carrier lot number"
      t.datetime "otr_carrier_expiry", precision: nil, comment: "Opentron carrier expiry date"
      t.string "otr_reaction_mix_7_lot_number", comment: "Opentron reaction mix 7 lot number"
      t.datetime "otr_reaction_mix_7_expiry", precision: nil, comment: "Opentron reaction mix 7 expiry date"
      t.string "otr_nfw_lot_number", comment: "Opentron NFW lot number"
      t.datetime "otr_nfw_expiry", precision: nil, comment: "Opentron NFW expiry date"
      t.string "otr_oil_lot_number", comment: "Opentron oil lot number"
      t.datetime "otr_oil_expiry", precision: nil, comment: "Opentron oil expiry date"
      t.string "otr_pipette_carousel", comment: "Opentron pipette carousel identifier"
      t.string "otr_instrument_name", null: false, comment: "Opentron instrument name"
      t.string "amp_assign_control_bead_tube", comment: "AMP assign control bead tube barcode"
      t.string "amp_instrument_name", null: false, comment: "AMP instrument name"
    end

    add_foreign_key :useq_wafer, :sample, column: :id_sample_tmp, primary_key: :id_sample_tmp, name: "useq_wafer_sample_fk"
    add_foreign_key :useq_wafer, :study, column: :id_study_tmp, primary_key: :id_study_tmp, name: "useq_wafer_study_fk"
    add_index :useq_wafer, %i[
      id_wafer_lims
      lane
      tag_sequence
      id_lims
    ], unique: true, name: 'index_useq_wafer_on_composition_keys'
  end
end
