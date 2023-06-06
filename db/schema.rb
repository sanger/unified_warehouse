# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_05_152453) do
  create_table "bmap_flowcell", primary_key: "id_bmap_flowcell_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "experiment_name", null: false, comment: "The name of the experiment, eg. The lims generated run id"
    t.string "instrument_name", null: false, comment: "The name of the instrument on which the sample was run"
    t.string "enzyme_name", null: false, comment: "The name of the recognition enzyme used"
    t.string "chip_barcode", null: false, comment: "Manufacturer chip identifier"
    t.string "chip_serialnumber", limit: 16, comment: "Manufacturer chip identifier"
    t.integer "position", comment: "Flowcell position", unsigned: true
    t.string "id_flowcell_lims", null: false, comment: "LIMs-specific flowcell id"
    t.string "id_library_lims", comment: "Earliest LIMs identifier associated with library creation"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.index ["id_flowcell_lims"], name: "index_bmap_flowcell_on_id_flowcell_lims"
    t.index ["id_library_lims"], name: "index_bmap_flowcell_on_id_library_lims"
    t.index ["id_sample_tmp"], name: "fk_bmap_flowcell_to_sample"
    t.index ["id_study_tmp"], name: "fk_bmap_flowcell_to_study"
  end

  create_table "flgen_plate", primary_key: "id_flgen_plate_tmp", id: { type: :integer, unsigned: true }, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "cost_code", limit: 20, null: false, comment: "Valid WTSI cost code"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE"
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.integer "plate_barcode", null: false, comment: "Manufacturer (Fluidigm) chip barcode", unsigned: true
    t.string "plate_barcode_lims", limit: 128, comment: "LIMs-specific plate barcode"
    t.string "plate_uuid_lims", limit: 36, comment: "LIMs-specific plate uuid"
    t.string "id_flgen_plate_lims", limit: 20, null: false, comment: "LIMs-specific plate id"
    t.integer "plate_size", limit: 2, comment: "Total number of wells on a plate"
    t.integer "plate_size_occupied", limit: 2, comment: "Number of occupied wells on a plate"
    t.string "well_label", limit: 10, null: false, comment: "Manufactuer well identifier within a plate, S001-S192"
    t.string "well_uuid_lims", limit: 36, comment: "LIMs-specific well uuid"
    t.boolean "qc_state", comment: "QC state; 1 (pass), 0 (fail), NULL (not known)"
    t.index ["id_lims", "id_flgen_plate_lims"], name: "flgen_plate_id_lims_id_flgen_plate_lims_index"
    t.index ["id_sample_tmp"], name: "flgen_plate_sample_fk"
    t.index ["id_study_tmp"], name: "flgen_plate_study_fk"
  end

  create_table "iseq_flowcell", primary_key: "id_iseq_flowcell_tmp", id: { type: :integer, unsigned: true }, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "cost_code", limit: 20, comment: "Valid WTSI cost code"
    t.boolean "is_r_and_d", default: false, comment: "A boolean flag derived from cost code, flags RandD"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE"
    t.integer "priority", limit: 2, default: 1, comment: "Priority", unsigned: true
    t.boolean "manual_qc", comment: "Legacy QC decision value set per lane which may be used for per-lane billing: iseq_product_metrics.qc is likely to contain the per product QC summary of use to most downstream users"
    t.boolean "external_release", comment: "Defaults to manual qc value; can be changed by the user later"
    t.string "flowcell_barcode", limit: 15, comment: "Manufacturer flowcell barcode or other identifier"
    t.string "reagent_kit_barcode", limit: 30, comment: "The barcode for the reagent kit or cartridge"
    t.string "id_flowcell_lims", limit: 20, null: false, comment: "LIMs-specific flowcell id, batch_id for Sequencescape"
    t.integer "position", limit: 2, null: false, comment: "Flowcell lane number", unsigned: true
    t.string "entity_type", limit: 30, null: false, comment: "Lane type: library, pool, library_control, library_indexed, library_indexed_spike"
    t.string "entity_id_lims", limit: 20, null: false, comment: "Most specific LIMs identifier associated with this lane or plex or spike"
    t.integer "tag_index", limit: 2, comment: "Tag index, NULL if lane is not a pool", unsigned: true
    t.string "tag_sequence", limit: 30, comment: "Tag sequence"
    t.string "tag_set_id_lims", limit: 20, comment: "LIMs-specific identifier of the tag set"
    t.string "tag_set_name", limit: 100, comment: "WTSI-wide tag set name"
    t.string "tag_identifier", limit: 30, comment: "The position of tag within the tag group"
    t.string "tag2_sequence", limit: 30, comment: "Tag sequence for tag 2"
    t.string "tag2_set_id_lims", limit: 20, comment: "LIMs-specific identifier of the tag set for tag 2"
    t.string "tag2_set_name", limit: 100, comment: "WTSI-wide tag set name for tag 2"
    t.string "tag2_identifier", limit: 30, comment: "The position of tag2 within the tag group"
    t.boolean "is_spiked", default: false, null: false, comment: "Boolean flag indicating presence of a spike"
    t.string "pipeline_id_lims", limit: 60, comment: "LIMs-specific pipeline identifier that unambiguously defines library type"
    t.string "bait_name", limit: 50, comment: "WTSI-wide name that uniquely identifies a bait set"
    t.integer "requested_insert_size_from", comment: "Requested insert size min value", unsigned: true
    t.integer "requested_insert_size_to", comment: "Requested insert size max value", unsigned: true
    t.integer "forward_read_length", limit: 2, comment: "Requested forward read length, bp", unsigned: true
    t.integer "reverse_read_length", limit: 2, comment: "Requested reverse read length, bp", unsigned: true
    t.string "id_pool_lims", limit: 20, null: false, comment: "Most specific LIMs identifier associated with the pool"
    t.integer "legacy_library_id", comment: "Legacy library_id for backwards compatibility."
    t.string "id_library_lims", comment: "Earliest LIMs identifier associated with library creation"
    t.string "team", comment: "The team responsible for creating the flowcell"
    t.string "purpose", limit: 30, comment: "Describes the reason the sequencing was conducted. Eg. Standard, QC, Control"
    t.boolean "suboptimal", comment: "Indicates that a sample has failed a QC step during processing"
    t.string "primer_panel", comment: "Primer Panel name"
    t.string "spiked_phix_barcode", limit: 20, comment: "Barcode of the PhiX tube added to the lane"
    t.float "spiked_phix_percentage", comment: "Percentage PhiX tube spiked in the pool in terms of molar concentration"
    t.float "loading_concentration", comment: "Final instrument loading concentration (pM)"
    t.string "workflow", limit: 20, comment: "Workflow used when processing the flowcell"
    t.index ["flowcell_barcode", "position", "tag_index"], name: "index_iseqflowcell__flowcell_barcode__position__tag_index"
    t.index ["id_flowcell_lims", "position", "tag_index", "id_lims"], name: "index_iseq_flowcell_id_flowcell_lims_position_tag_index_id_lims", unique: true
    t.index ["id_flowcell_lims", "position", "tag_index"], name: "index_iseqflowcell__id_flowcell_lims__position__tag_index"
    t.index ["id_library_lims"], name: "index_iseq_flowcell_on_id_library_lims"
    t.index ["id_lims", "id_flowcell_lims"], name: "iseq_flowcell_id_lims_id_flowcell_lims_index"
    t.index ["id_pool_lims"], name: "index_iseq_flowcell_on_id_pool_lims"
    t.index ["id_sample_tmp"], name: "iseq_flowcell_sample_fk"
    t.index ["id_study_tmp"], name: "iseq_flowcell_study_fk"
    t.index ["legacy_library_id"], name: "index_iseq_flowcell_legacy_library_id"
  end

  create_table "labware_location", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "item_barcode", null: false, comment: "Barcode on the stored labware"
    t.string "location_barcode", null: false, comment: "Barcode associated with storage location"
    t.string "full_location_address", null: false, comment: "Fully qualifed address of the nested location"
    t.integer "coord_position", comment: "Position"
    t.integer "coord_row", comment: "Row"
    t.integer "coord_column", comment: "Column"
    t.string "lims_id", null: false, comment: "ID of the storage system this data comes from"
    t.string "stored_by", null: false, comment: "Username of the person who placed the item there"
    t.datetime "stored_at", null: false, comment: "Datetime the item was stored at this location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_barcode"], name: "index_labware_location_on_location_barcode"
  end

  create_table "lighthouse_sample", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "mongodb_id", comment: "Auto-generated id from MongoDB"
    t.string "root_sample_id", null: false, comment: "Id for this sample provided by the Lighthouse lab"
    t.string "cog_uk_id", comment: "Consortium-wide id, generated by Sanger on import to LIMS"
    t.string "rna_id", null: false, comment: "Lighthouse lab-provided id made up of plate barcode and well"
    t.string "plate_barcode", comment: "Barcode of plate sample arrived in, from rna_id"
    t.string "coordinate", comment: "Well position from plate sample arrived in, from rna_id"
    t.string "result", null: false, comment: "Covid-19 test result from the Lighthouse lab"
    t.string "date_tested_string", comment: "When the covid-19 test was carried out by the Lighthouse lab"
    t.datetime "date_tested", precision: nil, comment: "date_tested_string in date format"
    t.string "source", comment: "Lighthouse centre that the sample came from"
    t.string "lab_id", comment: "Id of the lab, within the Lighthouse centre"
    t.string "ch1_target", comment: "Target for channel 1"
    t.string "ch1_result", comment: "Result for channel 1"
    t.decimal "ch1_cq", precision: 11, scale: 8, comment: "Cq value for channel 1"
    t.string "ch2_target", comment: "Target for channel 2"
    t.string "ch2_result", comment: "Result for channel 2"
    t.decimal "ch2_cq", precision: 11, scale: 8, comment: "Cq value for channel 2"
    t.string "ch3_target", comment: "Target for channel 3"
    t.string "ch3_result", comment: "Result for channel 3"
    t.decimal "ch3_cq", precision: 11, scale: 8, comment: "Cq value for channel 3"
    t.string "ch4_target", comment: "Target for channel 4"
    t.string "ch4_result", comment: "Result for channel 4"
    t.decimal "ch4_cq", precision: 11, scale: 8, comment: "Cq value for channel 4"
    t.boolean "filtered_positive", comment: "Filtered positive result value"
    t.string "filtered_positive_version", comment: "Filtered positive version"
    t.datetime "filtered_positive_timestamp", precision: nil, comment: "Filtered positive timestamp"
    t.string "lh_sample_uuid", limit: 36, comment: "Sample uuid created in crawler"
    t.string "lh_source_plate_uuid", limit: 36, comment: "Source plate uuid created in crawler"
    t.datetime "created_at", precision: nil, comment: "When this record was inserted"
    t.datetime "updated_at", precision: nil, comment: "When this record was last updated"
    t.boolean "must_sequence", comment: "PAM provided value whether sample is of high importance"
    t.boolean "preferentially_sequence", comment: "PAM provided value whether sample is important"
    t.boolean "is_current", default: false, null: false, comment: "Identifies if this sample has the most up to date information for the same rna_id"
    t.virtual "current_rna_id", type: :string, as: "if((`is_current` = 1),`rna_id`,NULL)", stored: true
    t.index ["cog_uk_id"], name: "index_lighthouse_sample_on_cog_uk_id", unique: true
    t.index ["current_rna_id"], name: "index_lighthouse_sample_on_current_rna_id", unique: true
    t.index ["date_tested"], name: "index_lighthouse_sample_on_date_tested"
    t.index ["filtered_positive"], name: "index_lighthouse_sample_on_filtered_positive"
    t.index ["lh_sample_uuid"], name: "index_lighthouse_sample_on_lh_sample_uuid", unique: true
    t.index ["mongodb_id"], name: "index_lighthouse_sample_on_mongodb_id", unique: true
    t.index ["plate_barcode", "created_at"], name: "index_lighthouse_sample_on_plate_barcode_and_created_at"
    t.index ["result"], name: "index_lighthouse_sample_on_result"
    t.index ["rna_id"], name: "index_lighthouse_sample_on_rna_id"
    t.index ["root_sample_id", "rna_id", "result"], name: "index_lighthouse_sample_on_root_sample_id_and_rna_id_and_result", unique: true
  end

  create_table "long_read_qc_result", primary_key: "id_long_read_qc_result_tmp", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "labware_barcode", null: false, comment: "Barcode of the labware that was the source for the QC tests."
    t.string "sample_id", null: false, comment: "External identifier for the sample(s)."
    t.string "assay_type", null: false, comment: "Type of the QC test."
    t.string "assay_type_key", null: false, comment: "Unique identifier of the QC test."
    t.string "units", comment: "Unit of the value for example mg,ng etc"
    t.string "value", null: false, comment: "QC result value"
    t.string "id_lims", comment: "Identifier of the LIMS where QC was published from"
    t.string "id_long_read_qc_result_lims", comment: "LIMS specific id for QC result"
    t.datetime "created", precision: nil, comment: "The date the qc_result was first created in LIMS"
    t.datetime "last_updated", precision: nil, comment: "The date the qc_result was last updated in LIMS."
    t.datetime "recorded_at", precision: nil, comment: "Timestamp of the latest warehouse update."
    t.string "qc_status", comment: "Status of the QC decision eg pass, fail etc"
    t.string "qc_status_decision_by", comment: "Who made the QC status decision eg ToL, Long Read"
  end

  create_table "oseq_flowcell", primary_key: "id_oseq_flowcell_tmp", id: { type: :integer, unsigned: true }, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_flowcell_lims", null: false, comment: "LIMs-specific flowcell id"
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "experiment_name", null: false, comment: "The name of the experiment, eg. The lims generated run id"
    t.string "instrument_name", null: false, comment: "The name of the instrument on which the sample was run"
    t.integer "instrument_slot", null: false, comment: "The numeric identifier of the slot on which the sample was run"
    t.string "pipeline_id_lims", comment: "LIMs-specific pipeline identifier that unambiguously defines library type"
    t.string "requested_data_type", comment: "The type of data produced by sequencing, eg. basecalls only"
    t.datetime "deleted_at", precision: nil, comment: "Timestamp of any flowcell destruction"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.string "tag_identifier", comment: "Position of the first tag within the tag group"
    t.string "tag_sequence", comment: "Sequence of the first tag"
    t.string "tag_set_id_lims", comment: "LIMs-specific identifier of the tag set for the first tag"
    t.string "tag_set_name", comment: "WTSI-wide tag set name for the first tag"
    t.string "tag2_identifier", comment: "Position of the second tag within the tag group"
    t.string "tag2_sequence", comment: "Sequence of the second tag"
    t.string "tag2_set_id_lims", comment: "LIMs-specific identifier of the tag set for the second tag"
    t.string "tag2_set_name", comment: "WTSI-wide tag set name for the second tag"
    t.string "flowcell_id", comment: "The id of the flowcell. Supplied with the flowcell. Format FAVnnnn"
    t.string "library_tube_uuid", limit: 36, comment: "The uuid for the originating library tube"
    t.string "library_tube_barcode", comment: "The barcode for the originating library tube"
    t.string "run_uuid", limit: 36, comment: "The uuid of the run"
    t.string "run_id", comment: "Run identifier assigned by MinKNOW"
    t.index ["id_sample_tmp"], name: "fk_oseq_flowcell_to_sample"
    t.index ["id_study_tmp"], name: "fk_oseq_flowcell_to_study"
  end

  create_table "pac_bio_run", primary_key: "id_pac_bio_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Sample id, see \"study.id_study_tmp\"", unsigned: true
    t.string "id_pac_bio_run_lims", limit: 20, null: false, comment: "Lims specific identifier for the pacbio run"
    t.string "pac_bio_run_uuid", limit: 36, comment: "Uuid identifier for the pacbio run"
    t.string "cost_code", limit: 20, null: false, comment: "Valid WTSI cost-code"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.string "tag_identifier", limit: 30, comment: "Tag index within tag set, NULL if untagged"
    t.string "tag_sequence", limit: 30, comment: "Tag sequence for tag"
    t.string "tag_set_id_lims", limit: 20, comment: "LIMs-specific identifier of the tag set for tag"
    t.string "tag_set_name", limit: 100, comment: "WTSI-wide tag set name for tag"
    t.string "tag2_sequence", limit: 30, comment: "Tag sequence for tag 2"
    t.string "tag2_set_id_lims", limit: 20, comment: "LIMs-specific identifier of the tag set for tag 2"
    t.string "tag2_set_name", limit: 100, comment: "WTSI-wide tag set name for tag 2"
    t.string "tag2_identifier", limit: 30, comment: "The position of tag2 within the tag group"
    t.string "plate_barcode", comment: "The human readable barcode for the plate loaded onto the machine"
    t.string "plate_uuid_lims", limit: 36, null: false, comment: "The plate uuid"
    t.string "well_label", null: false, comment: "The well identifier for the plate, A1-H12"
    t.string "well_uuid_lims", limit: 36, null: false, comment: "The well uuid"
    t.string "pac_bio_library_tube_id_lims", null: false, comment: "LIMS specific identifier for originating library tube"
    t.string "pac_bio_library_tube_uuid", null: false, comment: "The uuid for the originating library tube"
    t.string "pac_bio_library_tube_name", null: false, comment: "The name of the originating library tube"
    t.integer "pac_bio_library_tube_legacy_id", comment: "Legacy library_id for backwards compatibility."
    t.datetime "library_created_at", precision: nil, comment: "Timestamp of library creation"
    t.string "pac_bio_run_name", comment: "Name of the run"
    t.string "pipeline_id_lims", limit: 60, comment: "LIMS-specific pipeline identifier that unambiguously defines library type (eg. Sequel-v1, IsoSeq-v1)"
    t.virtual "comparable_tag_identifier", type: :string, as: "ifnull(`tag_identifier`,-(1))"
    t.virtual "comparable_tag2_identifier", type: :string, as: "ifnull(`tag2_identifier`,-(1))"
    t.integer "plate_number", comment: "The number of the plate that goes onto the sequencing machine. Necessary as an identifier for multi-plate support."
    t.string "pac_bio_library_tube_barcode", comment: "The barcode of the originating library tube"
    t.index ["id_lims", "id_pac_bio_run_lims", "well_label", "comparable_tag_identifier", "comparable_tag2_identifier"], name: "unique_pac_bio_entry", unique: true
    t.index ["id_sample_tmp"], name: "fk_pac_bio_run_to_sample"
    t.index ["id_study_tmp"], name: "fk_pac_bio_run_to_study"
  end

  create_table "psd_sample_compounds_components", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", comment: "A join table owned by PSD to associate compound samples with their component samples.", force: :cascade do |t|
    t.integer "compound_id_sample_tmp", null: false, comment: "The warehouse ID of the compound sample in the association."
    t.integer "component_id_sample_tmp", null: false, comment: "The warehouse ID of the component sample in the association."
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update."
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update."
  end

  create_table "qc_result", primary_key: "id_qc_result_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id_sample_tmp", null: false, unsigned: true
    t.string "id_qc_result_lims", limit: 20, null: false, comment: "LIMS-specific qc_result identifier"
    t.string "id_lims", limit: 10, null: false, comment: "LIMS system identifier (e.g. SEQUENCESCAPE)"
    t.string "id_pool_lims", comment: "Most specific LIMs identifier associated with the pool. (Asset external_identifier in SS)"
    t.string "id_library_lims", comment: "Earliest LIMs identifier associated with library creation. (Aliquot external_identifier in SS)"
    t.string "labware_purpose", comment: "Labware Purpose name. (e.g. Plate Purpose for a Well)"
    t.string "assay", comment: "assay type and version"
    t.string "value", null: false, comment: "Value of the mesurement"
    t.string "units", null: false, comment: "Mesurement unit"
    t.float "cv", comment: "Coefficient of variance"
    t.string "qc_type", null: false, comment: "Type of mesurement"
    t.datetime "date_created", precision: nil, null: false, comment: "The date the qc_result was first created in SS"
    t.datetime "last_updated", precision: nil, null: false, comment: "The date the qc_result was last updated in SS"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.index ["id_library_lims"], name: "qc_result_id_library_lims_index"
    t.index ["id_qc_result_lims", "id_lims"], name: "lookup_index"
    t.index ["id_sample_tmp"], name: "fk_qc_result_to_sample"
  end

  create_table "sample", primary_key: "id_sample_tmp", id: { type: :integer, unsigned: true }, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE"
    t.string "uuid_sample_lims", limit: 36, comment: "LIMS-specific sample uuid"
    t.string "id_sample_lims", limit: 20, null: false, comment: "LIMS-specific sample identifier"
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.datetime "deleted_at", precision: nil, comment: "Timestamp of sample deletion"
    t.datetime "created", precision: nil, comment: "Timestamp of sample creation"
    t.string "name"
    t.string "reference_genome"
    t.string "organism"
    t.string "accession_number", comment: "A unique identifier generated by the INSDC"
    t.string "common_name"
    t.text "description"
    t.integer "taxon_id", unsigned: true
    t.string "father"
    t.string "mother"
    t.string "replicate"
    t.string "ethnicity"
    t.string "gender", limit: 20
    t.string "cohort"
    t.string "country_of_origin"
    t.string "geographical_region"
    t.string "sanger_sample_id"
    t.boolean "control"
    t.string "supplier_name"
    t.string "public_name"
    t.string "sample_visibility"
    t.string "strain"
    t.boolean "consent_withdrawn", default: false, null: false
    t.string "donor_id"
    t.string "phenotype", comment: "The phenotype of the sample as described in Sequencescape"
    t.string "developmental_stage", comment: "Developmental Stage"
    t.string "control_type"
    t.string "sibling"
    t.boolean "is_resubmitted"
    t.string "date_of_sample_collection"
    t.string "date_of_sample_extraction"
    t.string "extraction_method"
    t.string "purified"
    t.string "purification_method"
    t.string "customer_measured_concentration"
    t.string "concentration_determined_by"
    t.string "sample_type"
    t.string "storage_conditions"
    t.string "genotype"
    t.string "age"
    t.string "cell_type"
    t.string "disease_state"
    t.string "compound"
    t.string "dose"
    t.string "immunoprecipitate"
    t.string "growth_condition"
    t.string "organism_part"
    t.string "time_point"
    t.string "disease"
    t.string "subject"
    t.string "treatment"
    t.datetime "date_of_consent_withdrawn", precision: nil
    t.string "marked_as_consent_withdrawn_by"
    t.string "customer_measured_volume"
    t.string "gc_content"
    t.string "dna_source"
    t.index ["accession_number"], name: "sample_accession_number_index"
    t.index ["id_sample_lims", "id_lims"], name: "index_sample_on_id_sample_lims_and_id_lims", unique: true
    t.index ["name"], name: "sample_name_index"
    t.index ["sanger_sample_id"], name: "index_sample_on_sanger_sample_id"
    t.index ["supplier_name"], name: "index_sample_on_supplier_name"
    t.index ["uuid_sample_lims"], name: "sample_uuid_sample_lims_index", unique: true
  end

  create_table "samples_extraction_activity", primary_key: "id_activity_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_activity_lims", null: false, comment: "LIMs-specific activity id"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.string "activity_type", null: false, comment: "The type of the activity performed"
    t.string "instrument", null: false, comment: "The name of the instrument used to perform the activity"
    t.string "kit_barcode", null: false, comment: "The barcode of the kit used to perform the activity"
    t.string "kit_type", null: false, comment: "The type of kit used to perform the activity"
    t.string "input_barcode", null: false, comment: "The barcode of the labware (eg. plate or tube) at the begining of the activity"
    t.string "output_barcode", null: false, comment: "The barcode of the labware (eg. plate or tube)  at the end of the activity"
    t.string "user", null: false, comment: "The name of the user who was most recently associated with the activity"
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last change to activity"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.datetime "completed_at", precision: nil, null: false, comment: "Timestamp of activity completion"
    t.datetime "deleted_at", precision: nil, comment: "Timestamp of any activity removal"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.index ["id_activity_lims"], name: "index_samples_extraction_activity_on_id_activity_lims"
    t.index ["id_sample_tmp"], name: "fk_rails_bbdd0468f0"
  end

  create_table "stock_resource", primary_key: "id_stock_resource_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.datetime "created", precision: nil, null: false, comment: "Timestamp of initial registration of stock in LIMS"
    t.datetime "deleted_at", precision: nil, comment: "Timestamp of initial registration of deletion in parent LIMS. NULL if not deleted."
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Sample id, see \"study.id_study_tmp\"", unsigned: true
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.string "id_stock_resource_lims", limit: 20, null: false, comment: "Lims specific identifier for the stock"
    t.string "stock_resource_uuid", limit: 36, comment: "Uuid identifier for the stock"
    t.string "labware_type", null: false, comment: "The type of labware containing the stock. eg. Well, Tube"
    t.string "labware_machine_barcode", null: false, comment: "The barcode of the containing labware as read by a barcode scanner"
    t.string "labware_human_barcode", null: false, comment: "The barcode of the containing labware in human readable format"
    t.string "labware_coordinate", comment: "For wells, the coordinate on the containing plate. Null for tubes."
    t.float "current_volume", comment: "The current volume of material in microlitres based on measurements and know usage"
    t.float "initial_volume", comment: "The result of the initial volume measurement in microlitres conducted on the material"
    t.float "concentration", comment: "The concentration of material recorded in the lab in nanograms per microlitre"
    t.string "gel_pass", comment: "The recorded result for the qel QC assay."
    t.string "pico_pass", comment: "The recorded result for the pico green assay. A pass indicates a successful assay, not sufficient material."
    t.integer "snp_count", comment: "The number of markers detected in genotyping assays"
    t.string "measured_gender", comment: "The gender call base on the genotyping assay"
    t.index ["id_sample_tmp"], name: "fk_stock_resource_to_sample"
    t.index ["id_stock_resource_lims", "id_sample_tmp", "id_lims"], name: "composition_lookup_index"
    t.index ["id_study_tmp"], name: "fk_stock_resource_to_study"
  end

  create_table "study", primary_key: "id_study_tmp", id: { type: :integer, unsigned: true }, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. GCLP-CLARITY, SEQSCAPE"
    t.string "uuid_study_lims", limit: 36, comment: "LIMS-specific study uuid"
    t.string "id_study_lims", limit: 20, null: false, comment: "LIMS-specific study identifier"
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", precision: nil, null: false, comment: "Timestamp of warehouse update"
    t.datetime "deleted_at", precision: nil, comment: "Timestamp of study deletion"
    t.datetime "created", precision: nil, comment: "Timestamp of study creation"
    t.string "name"
    t.string "reference_genome"
    t.boolean "ethically_approved"
    t.string "faculty_sponsor"
    t.string "state", limit: 50
    t.string "study_type", limit: 50
    t.text "abstract"
    t.string "abbreviation"
    t.string "accession_number", limit: 50
    t.text "description"
    t.boolean "contains_human_dna", comment: "Lane may contain human DNA"
    t.boolean "contaminated_human_dna", comment: "Human DNA in the lane is a contaminant and should be removed"
    t.string "data_release_strategy"
    t.string "data_release_sort_of_study"
    t.string "ena_project_id"
    t.string "study_title"
    t.string "study_visibility"
    t.string "ega_dac_accession_number"
    t.string "array_express_accession_number"
    t.string "ega_policy_accession_number"
    t.string "data_release_timing"
    t.string "data_release_delay_period"
    t.string "data_release_delay_reason"
    t.boolean "remove_x_and_autosomes", default: false, null: false
    t.boolean "aligned", default: true, null: false
    t.boolean "separate_y_chromosome_data", default: false, null: false
    t.string "data_access_group"
    t.string "prelim_id", limit: 20, comment: "The preliminary study id prior to entry into the LIMS"
    t.string "hmdmc_number", comment: "The Human Materials and Data Management Committee approval number(s) for the study."
    t.string "data_destination", comment: "The data destination type(s) for the study. It could be 'standard', '14mg' or 'gseq'. This may be extended, if Sanger gains more external customers. It can contain multiply destinations separated by a space."
    t.string "s3_email_list"
    t.string "data_deletion_period"
    t.index ["accession_number"], name: "study_accession_number_index"
    t.index ["id_lims", "id_study_lims"], name: "study_id_lims_id_study_lims_index", unique: true
    t.index ["name"], name: "study_name_index"
    t.index ["uuid_study_lims"], name: "study_uuid_study_lims_index", unique: true
  end

  create_table "study_users", primary_key: "id_study_users_tmp", id: { type: :integer, unsigned: true }, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.datetime "last_updated", precision: nil, null: false, comment: "Timestamp of last update"
    t.string "role"
    t.string "login"
    t.string "email"
    t.string "name"
    t.index ["id_study_tmp"], name: "study_users_study_fk"
  end

  add_foreign_key "bmap_flowcell", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_bmap_flowcell_to_sample"
  add_foreign_key "bmap_flowcell", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_bmap_flowcell_to_study"
  add_foreign_key "flgen_plate", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "flgen_plate_sample_fk"
  add_foreign_key "flgen_plate", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "flgen_plate_study_fk"
  add_foreign_key "iseq_flowcell", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "iseq_flowcell_sample_fk"
  add_foreign_key "iseq_flowcell", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "iseq_flowcell_study_fk"
  add_foreign_key "oseq_flowcell", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_oseq_flowcell_to_sample"
  add_foreign_key "oseq_flowcell", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_oseq_flowcell_to_study"
  add_foreign_key "pac_bio_run", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_pac_bio_run_to_sample"
  add_foreign_key "pac_bio_run", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_pac_bio_run_to_study"
  add_foreign_key "qc_result", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_qc_result_to_sample"
  add_foreign_key "samples_extraction_activity", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp"
  add_foreign_key "stock_resource", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_stock_resource_to_sample"
  add_foreign_key "stock_resource", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_stock_resource_to_study"
  add_foreign_key "study_users", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "study_users_study_fk"
end
