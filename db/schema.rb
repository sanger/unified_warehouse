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

ActiveRecord::Schema.define(version: 2022_03_02_143137) do

  create_table "bmap_flowcell", primary_key: "id_bmap_flowcell_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
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

  create_table "cgap_analyte", primary_key: "cgap_analyte_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "cell_line_uuid", limit: 36, null: false
    t.string "destination", limit: 32, null: false
    t.string "jobs", limit: 64
    t.string "slot_uuid", limit: 36, null: false
    t.timestamp "release_date", null: false
    t.string "labware_barcode", limit: 20, null: false
    t.integer "passage_number"
    t.string "cell_state", limit: 40, null: false
    t.string "project", limit: 50
    t.index ["cell_line_uuid"], name: "cell_line_uuid"
    t.index ["slot_uuid"], name: "slot_uuid", unique: true
  end

  create_table "cgap_biomaterial", primary_key: "cgap_biomaterial_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "donor_uuid", limit: 36, null: false
    t.string "donor_accession_number", limit: 38
    t.string "donor_name", limit: 64
    t.string "biomaterial_uuid", limit: 36, null: false
    t.index ["biomaterial_uuid"], name: "biomaterial_uuid", unique: true
    t.index ["donor_uuid"], name: "donor_uuid"
  end

  create_table "cgap_conjured_labware", primary_key: "cgap_conjured_labware_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "barcode", limit: 32, null: false
    t.string "cell_line_long_name", limit: 48, null: false
    t.string "cell_line_uuid", limit: 38, null: false
    t.integer "passage_number", null: false
    t.string "fate", limit: 40
    t.timestamp "conjure_date", null: false
    t.string "labware_state", limit: 20, null: false
    t.string "project", limit: 50
    t.string "slot_uuid", limit: 36, null: false
    t.index ["barcode"], name: "barcode"
    t.index ["cell_line_long_name"], name: "cell_line_long_name"
    t.index ["cell_line_uuid"], name: "cell_line_uuid"
    t.index ["conjure_date"], name: "conjure_date"
    t.index ["labware_state"], name: "labware_state"
    t.index ["project"], name: "project"
    t.index ["slot_uuid"], name: "slot_uuid", unique: true
  end

  create_table "cgap_heron", primary_key: "cgap_heron_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "container_barcode", limit: 32, null: false
    t.string "tube_barcode", limit: 32
    t.string "supplier_sample_id", limit: 64, null: false
    t.string "position", limit: 8, null: false
    t.string "sample_type", limit: 32, null: false
    t.timestamp "release_time", null: false
    t.string "study", limit: 32, null: false
    t.string "destination", limit: 32, null: false
    t.timestamp "wrangled"
    t.string "sample_state", limit: 32, null: false
    t.string "lysis_buffer", limit: 64
    t.integer "priority", limit: 1
    t.string "sample_identifier", limit: 64, comment: "The COG-UK barcode of a sample or the mixtio barcode of a control"
    t.column "control_type", "enum('Positive','Negative')"
    t.string "control_accession_number", limit: 32
    t.index ["container_barcode", "position"], name: "cgap_heron_rack_and_position", unique: true
    t.index ["destination", "wrangled"], name: "cgap_heron_destination_wrangled"
    t.index ["release_time"], name: "cgap_heron_release_time"
    t.index ["sample_identifier"], name: "cgap_heron_sample_identifier"
    t.index ["study"], name: "cgap_heron_study"
    t.index ["supplier_sample_id"], name: "cgap_heron_supplier_sample_id"
    t.index ["tube_barcode"], name: "tube_barcode", unique: true
  end

  create_table "cgap_line_identifier", primary_key: "cgap_line_identifier_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "line_uuid", limit: 36, null: false
    t.string "friendly_name", limit: 48, null: false
    t.string "accession_number", limit: 38
    t.string "direct_parent_uuid", limit: 36
    t.string "biomaterial_uuid", limit: 36, null: false
    t.string "project", limit: 50
    t.index ["biomaterial_uuid"], name: "biomaterial_uuid"
    t.index ["direct_parent_uuid"], name: "direct_parent_uuid"
    t.index ["friendly_name"], name: "friendly_name"
    t.index ["line_uuid"], name: "line_uuid", unique: true
  end

  create_table "cgap_organoids_conjured_labware", primary_key: "cgap_organoids_conjured_labware_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "barcode", limit: 20, null: false
    t.string "cell_line_long_name", limit: 48, null: false
    t.string "cell_line_uuid", limit: 38, null: false
    t.integer "passage_number", null: false
    t.string "fate", limit: 40
    t.timestamp "conjure_date", null: false
    t.string "labware_state", limit: 20, null: false
    t.index ["barcode"], name: "barcode"
    t.index ["cell_line_long_name"], name: "cell_line_long_name"
    t.index ["cell_line_uuid"], name: "cell_line_uuid"
    t.index ["conjure_date"], name: "conjure_date"
    t.index ["labware_state"], name: "labware_state"
  end

  create_table "cgap_release", primary_key: "cgap_release_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "barcode", limit: 20, null: false
    t.string "cell_line_long_name", limit: 48, null: false
    t.string "cell_line_uuid", limit: 38, null: false
    t.string "goal", limit: 64, null: false
    t.string "jobs", limit: 64, null: false
    t.string "destination", limit: 64
    t.string "user", limit: 6, null: false
    t.timestamp "release_date", null: false
    t.string "cell_state", limit: 40, null: false
    t.string "fate", limit: 40
    t.integer "passage_number", null: false
    t.string "project", limit: 50
    t.index ["barcode"], name: "barcode"
    t.index ["cell_line_long_name"], name: "cell_line_long_name"
    t.index ["cell_line_uuid"], name: "cell_line_uuid"
    t.index ["project"], name: "project"
  end

  create_table "cgap_supplier_barcode", primary_key: "cgap_supplier_barcode_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "biomaterial_uuid", limit: 36, null: false
    t.string "supplier_barcode", limit: 20, null: false
    t.timestamp "date", null: false
    t.index ["biomaterial_uuid"], name: "biomaterial_uuid"
    t.index ["supplier_barcode"], name: "supplier_barcode", unique: true
  end

  create_table "flgen_plate", primary_key: "id_flgen_plate_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "cost_code", limit: 20, null: false, comment: "Valid WTSI cost code"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE"
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
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

  create_table "iseq_external_product_components", primary_key: "id_iseq_ext_pr_components_tmp", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", comment: "Table linking iseq_external_product_metrics table products to components in the iseq_product_metrics table", force: :cascade do |t|
    t.string "id_iseq_product_ext", limit: 64, null: false, comment: "id (digest) for the external product composition"
    t.string "id_iseq_product", limit: 64, null: false, comment: "id (digest) for one of the products components"
    t.integer "num_components", limit: 1, null: false, comment: "Number of component products for this product", unsigned: true
    t.integer "component_index", limit: 1, null: false, comment: "Unique component index within all components of this product, a value from 1 to the value of num_components column for this product", unsigned: true
    t.index ["component_index", "num_components"], name: "iseq_ext_pr_comp_compi"
    t.index ["id_iseq_product", "id_iseq_product_ext"], name: "iseq_ext_pr_comp_unique", unique: true
    t.index ["id_iseq_product_ext"], name: "iseq_ext_pr_comp_pr_comp_fk"
    t.index ["num_components", "id_iseq_product"], name: "iseq_ext_pr_comp_ncomp"
  end

  create_table "iseq_external_product_metrics", primary_key: "id_iseq_ext_pr_metrics_tmp", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", comment: "Externally computed metrics for data sequenced at WSI", force: :cascade do |t|
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }, comment: "Datetime this record was created"
    t.datetime "last_changed", default: -> { "CURRENT_TIMESTAMP" }, comment: "Datetime this record was created or changed"
    t.string "supplier_sample_name", collation: "utf8_unicode_ci", comment: "Sample name given by the supplier, as recorded by WSI"
    t.string "plate_barcode", collation: "utf8_unicode_ci", comment: "Stock plate barcode, as recorded by WSI"
    t.integer "library_id", comment: "WSI library identifier"
    t.string "file_name", limit: 300, null: false, comment: "Comma-delimitered alphabetically sorted list of file names, which unambigiously define WSI sources of data"
    t.string "file_path", limit: 760, null: false, comment: "Comma-delimitered alphabetically sorted list of full external file paths for the files in file_names column as uploaded by WSI"
    t.string "md5_staging", limit: 32, comment: "WSI validation hex MD5, not set for multiple source files"
    t.string "manifest_upload_status", limit: 15, comment: "WSI manifest upload status, one of \"IN PROGRESS\", \"DONE\", \"FAIL\", not set for multiple source files"
    t.datetime "manifest_upload_status_change_date", comment: "Date the status of manifest upload is changed by WSI"
    t.integer "id_run", comment: "NPG run identifier, defined where the product corresponds to a single line", unsigned: true
    t.string "id_iseq_product", limit: 64, collation: "utf8_unicode_ci", comment: "product id"
    t.string "iseq_composition_tmp", limit: 600, comment: "JSON representation of the composition object, the column might be deleted in future"
    t.string "id_archive_product", limit: 64, comment: "Archive ID for data product"
    t.string "destination", limit: 15, default: "UKBMP", comment: "Data destination, from 20200323 defaults to \"UKBMP\""
    t.string "processing_status", limit: 15, comment: "Overall status of the product, one of \"PASS\", \"HOLD\", \"INSUFFICIENT\", \"FAIL\""
    t.string "qc_overall_assessment", limit: 4, comment: "State of the product after phase 3 of processing, one of \"PASS\" or \"FAIL\""
    t.string "qc_status", limit: 15, comment: "State of the product after phase 2 of processing, one of \"PASS\", \"HOLD\", \"INSUFFICIENT\", \"FAIL\""
    t.date "sequencing_start_date", comment: "Sequencing start date obtained from the CRAM file header, not set for multiple source files"
    t.date "upload_date", comment: "Upload date, not set for multiple source files"
    t.date "md5_validation_date", comment: "Date of MD5 validation, not set for multiple source files"
    t.date "processing_start_date", comment: "Processing start date"
    t.date "analysis_start_date"
    t.datetime "phase2_end_date", comment: "Date the phase 2 analysis finished for this product"
    t.date "analysis_end_date"
    t.date "archival_date", comment: "Date made available or pushed to archive service"
    t.date "archive_confirmation_date", comment: "Date of confirmation of integrity of data product by archive service"
    t.string "md5", limit: 32, comment: "External validation hex MD5, not set for multiple source files"
    t.string "md5_validation", limit: 4, comment: "Outcome of MD5 validation as \"PASS\" or \"FAIL\", not set for multiple source files"
    t.string "format_validation", limit: 4, comment: "Outcome of format validation as \"PASS\" or \"FAIL\", not set for multiple source files"
    t.string "upload_status", limit: 4, comment: "Upload status as \"PASS\" or \"FAIL\", \"PASS\" if both MD5 and format validation are \"PASS\", not set for multiple source files"
    t.string "instrument_id", limit: 256, comment: "Comma separated sorted list of instrument IDs obtained from the CRAM file header(s)"
    t.string "flowcell_id", limit: 256, comment: "Comma separated sorted list of flowcell IDs obtained from the CRAM file header(s)"
    t.string "annotation", limit: 15, comment: "Annotation regarding data provenance, i.e. is sequence data from first pass, re-run, top-up, etc."
    t.integer "min_read_length", limit: 1, comment: "Minimum read length observed in the data file", unsigned: true
    t.integer "target_autosome_coverage_threshold", default: 15, comment: "Target autosome coverage threshold, defaults to 15", unsigned: true
    t.float "target_autosome_gt_coverage_threshold", comment: "Coverage percent at >= target_autosome_coverage_threshold X as a fraction"
    t.string "target_autosome_gt_coverage_threshold_assessment", limit: 4, comment: "\"PASS\" if target_autosome_percent_gt_coverage_threshold > 95%, \"FAIL\" otherwise"
    t.float "verify_bam_id_score", comment: "FREEMIX value of sample contamination levels as a fraction", unsigned: true
    t.string "verify_bam_id_score_assessment", limit: 4, comment: "\"PASS\" if verify_bam_id_score > 0.01, \"FAIL\" otherwise"
    t.float "double_error_fraction", comment: "Fraction of marker pairs with two read pairs evidencing parity and non-parity, may only be calculated if 1% <= verify_bam_id_score < 5%", unsigned: true
    t.string "contamination_assessment", limit: 4, comment: "\"PASS\" or \"FAIL\" based on verify_bam_id_score_assessment and double_error_fraction < 0.2%"
    t.float "yield_whole_genome", comment: "Sequence data quantity (Gb) excluding duplicate reads, adaptors, overlapping bases from reads on the same fragment, soft-clipped bases", unsigned: true
    t.float "yield", comment: "Sequence data quantity (Gb) excluding duplicate reads, adaptors, overlapping bases from reads on the same fragment, soft-clipped bases, non-N autosome only", unsigned: true
    t.bigint "yield_q20", comment: "Yield in bases at or above Q20 filtered in the same way as the yield column values", unsigned: true
    t.bigint "yield_q30", comment: "Yield in bases at or above Q30 filtered in the same way as the yield column values", unsigned: true
    t.bigint "num_reads", comment: "Number of reads filtered in the same way as the yield column values", unsigned: true
    t.float "gc_fraction_forward_read", unsigned: true
    t.float "gc_fraction_reverse_read", unsigned: true
    t.string "adapter_contamination", comment: "The maximum over adapters and cycles in reads/fragments as a fraction per file and RG. Values for first and second reads separated with \",\", and values for individual files separated with \"/\". e.g. \"0.1/0.1/0.1/0.1,0.1/0.1/0.1/0.1\""
    t.string "adapter_contamination_assessment", comment: "\"PASS\", \"WARN\", \"FAIL\" per read and file. Multiple values are represented as forward slash-separated array of strings with a comma separating entries for paired-end 1 and 2 reads e.g. \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.integer "pre_adapter_min_total_qscore", limit: 1, comment: "Minimum of TOTAL_QSCORE values in PreAdapter report from CollectSequencingArtifactMetrics", unsigned: true
    t.integer "ref_bias_min_total_qscore", limit: 1, comment: "Minimum of TOTAL_QSCORE values in BaitBias report from CollectSequencingArtifactMetrics", unsigned: true
    t.float "target_proper_pair_mapped_reads_fraction", comment: "Fraction of properly paired mapped reads filtered in the same way as the yield column values", unsigned: true
    t.string "target_proper_pair_mapped_reads_assessment", limit: 4, comment: "\"PASS\" if target_proper_pair_mapped_reads_fraction > 0.95, \"FAIL\" otherwise"
    t.float "insert_size_mean", unsigned: true
    t.float "insert_size_std", unsigned: true
    t.float "sequence_error_rate", comment: "Reported by samtools, as a fraction", unsigned: true
    t.string "basic_statistics_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "overrepresented_sequences_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "n_content_per_base_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "sequence_content_per_base_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "sequence_quality_per_base_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "gc_content_per_sequence_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "quality_scores_per_sequence_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "sequence_duplication_levels_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "sequence_length_distribution_assessement", comment: "FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\""
    t.string "FastQC_overall_assessment", limit: 4, comment: "FastQC \"PASS\" or \"FAIL\""
    t.float "nrd", comment: "Sample discordance levels at non-reference genotypes as a fraction", unsigned: true
    t.string "nrd_assessment", limit: 4, comment: "\"PASS\" based on nrd_persent < 2% or \"FAIL\" or \"NA\" if genotyping data not available for this sample"
    t.string "sex_reported", limit: 6, comment: "Sex as reported by sample supplier"
    t.string "sex_computed", limit: 6, comment: "Genetic sex as identified by sequence data"
    t.index ["file_name"], name: "iseq_ext_pr_fname"
    t.index ["file_path"], name: "iseq_ext_pr_file_path", unique: true
    t.index ["flowcell_id"], name: "iseq_ext_pr_flowcell"
    t.index ["id_iseq_product"], name: "iseq_ext_pr_id_product"
    t.index ["id_run"], name: "iseq_ext_pr_id_run"
    t.index ["instrument_id"], name: "iseq_ext_pr_instrument"
    t.index ["library_id"], name: "iseq_ext_pr_lib_id"
    t.index ["manifest_upload_status"], name: "iseq_ext_pr_manifest_status"
    t.index ["plate_barcode"], name: "iseq_ext_pr_plate_bc"
    t.index ["processing_status"], name: "iseq_ext_pr_prstatus"
    t.index ["qc_overall_assessment"], name: "iseq_ext_pr_qc"
    t.index ["supplier_sample_name"], name: "iseq_ext_pr_sample_name"
  end

  create_table "iseq_flowcell", primary_key: "id_iseq_flowcell_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "cost_code", limit: 20, comment: "Valid WTSI cost code"
    t.boolean "is_r_and_d", default: false, comment: "A boolean flag derived from cost code, flags RandD"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE"
    t.integer "priority", limit: 2, default: 1, comment: "Priority", unsigned: true
    t.boolean "manual_qc", comment: "Manual QC decision, NULL for unknown"
    t.boolean "external_release", comment: "Defaults to manual qc value; can be changed by the user later"
    t.string "flowcell_barcode", limit: 15, comment: "Manufacturer flowcell barcode or other identifier"
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

  create_table "iseq_heron_product_metrics", primary_key: "id_iseq_hrpr_metrics_tmp", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", comment: "Heron project additional metrics", force: :cascade do |t|
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }, comment: "Datetime this record was created"
    t.datetime "last_changed", default: -> { "CURRENT_TIMESTAMP" }, comment: "Datetime this record was created or changed"
    t.integer "id_run", comment: "Run id", unsigned: true
    t.string "id_iseq_product", limit: 64, null: false, comment: "Product id, a foreign key into iseq_product_metrics table"
    t.string "supplier_sample_name", comment: "Sample name given by the supplier, as recorded by WSI"
    t.string "pp_name", limit: 40, default: "ncov2019-artic-nf", comment: "The name of the pipeline that produced the QC metric"
    t.string "pp_version", limit: 40, comment: "The version of the pipeline specified in the pp_name column"
    t.string "artic_qc_outcome", limit: 15, comment: "Artic pipeline QC outcome, \"TRUE\", \"FALSE\" or a NULL value"
    t.datetime "climb_upload", comment: "Datetime files for this sample were uploaded to CLIMB"
    t.integer "cog_sample_meta", limit: 1, comment: "A Boolean flag to mark sample metadata upload to COG", unsigned: true
    t.string "path_root", comment: "The uploaded files path root for the entity"
    t.float "pct_N_bases", comment: "Percent of N bases"
    t.float "pct_covered_bases", comment: "Percent of covered bases"
    t.integer "longest_no_N_run", limit: 2, comment: "Longest consensus data stretch without N", unsigned: true
    t.bigint "num_aligned_reads", comment: "Number of aligned filtered reads", unsigned: true
    t.index ["id_iseq_product"], name: "iseq_hrm_digest_unq", unique: true
    t.index ["id_run"], name: "iseq_hrm_idrun"
    t.index ["pp_version"], name: "iseq_hrm_ppver"
    t.index ["supplier_sample_name"], name: "iseq_hrm_ssn"
  end

  create_table "iseq_product_ampliconstats", primary_key: "id_iseq_pr_astats_tmp", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", comment: "Some of per sample per amplicon metrics generated by samtools ampliconstats", force: :cascade do |t|
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }, comment: "Datetime this record was created"
    t.datetime "last_changed", default: -> { "CURRENT_TIMESTAMP" }, comment: "Datetime this record was created or changed"
    t.string "id_iseq_product", limit: 64, null: false, comment: "Product id, a foreign key into iseq_product_metrics table"
    t.string "primer_panel", null: false, comment: "A string uniquely identifying the primer panel"
    t.integer "primer_panel_num_amplicons", limit: 2, null: false, comment: "Total number of amplicons in the primer panel", unsigned: true
    t.integer "amplicon_index", limit: 2, null: false, comment: "Amplicon index (position) in the primer panel, from 1 to the value of primer_panel_num_amplicons", unsigned: true
    t.string "pp_name", limit: 40, null: false, comment: "Name of the portable pipeline that generated the data"
    t.string "pp_version", limit: 40, comment: "Version of the portable pipeline and/or samtools that generated the data"
    t.decimal "metric_FPCOV_1", precision: 5, scale: 2, comment: "Coverage percent at depth 1"
    t.decimal "metric_FPCOV_10", precision: 5, scale: 2, comment: "Coverage percent at depth 10"
    t.decimal "metric_FPCOV_20", precision: 5, scale: 2, comment: "Coverage percent at depth 20"
    t.decimal "metric_FPCOV_100", precision: 5, scale: 2, comment: "Coverage percent at depth 100"
    t.integer "metric_FREADS", comment: "Number of aligned filtered reads", unsigned: true
    t.index ["id_iseq_product", "primer_panel", "amplicon_index"], name: "iseq_hrm_digest_unq", unique: true
    t.index ["primer_panel_num_amplicons", "amplicon_index"], name: "iseq_pastats_amplicon"
  end

  create_table "iseq_product_components", primary_key: "id_iseq_pr_components_tmp", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "id_iseq_pr_tmp", null: false, comment: "iseq_product_metrics table row id for the product", unsigned: true
    t.bigint "id_iseq_pr_component_tmp", null: false, comment: "iseq_product_metrics table row id for one of this product's components", unsigned: true
    t.integer "num_components", limit: 1, null: false, comment: "Number of component products for this product", unsigned: true
    t.integer "component_index", limit: 1, null: false, comment: "Unique component index within all components of this product, \na value from 1 to the value of num_components column for this product", unsigned: true
    t.index ["component_index", "num_components"], name: "iseq_pr_comp_compi"
    t.index ["id_iseq_pr_component_tmp"], name: "iseq_pr_comp_pr_comp_fk"
    t.index ["id_iseq_pr_tmp", "id_iseq_pr_component_tmp"], name: "iseq_pr_comp_unique", unique: true
    t.index ["num_components", "id_iseq_pr_tmp"], name: "iseq_pr_comp_ncomp"
  end

  create_table "iseq_product_metrics", primary_key: "id_iseq_pr_metrics_tmp", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_iseq_product", limit: 64, null: false, comment: "Product id"
    t.datetime "last_changed", default: -> { "CURRENT_TIMESTAMP" }, comment: "Date this record was created or changed"
    t.integer "id_iseq_flowcell_tmp", comment: "Flowcell id, see \"iseq_flowcell.id_iseq_flowcell_tmp\"", unsigned: true
    t.integer "id_run", comment: "NPG run identifier", unsigned: true
    t.integer "position", limit: 2, comment: "Flowcell lane number", unsigned: true
    t.integer "tag_index", limit: 2, comment: "Tag index, NULL if lane is not a pool", unsigned: true
    t.string "iseq_composition_tmp", limit: 600, comment: "JSON representation of the composition object, the column might be deleted in future"
    t.boolean "qc_seq", comment: "Sequencing lane level QC outcome, a result of either manual or automatic assessment by core"
    t.boolean "qc_lib", comment: "Library QC outcome, a result of either manual or automatic assessment by core"
    t.boolean "qc_user", comment: "Library QC outcome according to the data user criteria, a result of either manual or automatic assessment"
    t.boolean "qc", comment: "Overall QC assessment outcome, a logical product (conjunction) of qc_seq and qc_lib values, defaults to the qc_seq value when qc_lib is not defined"
    t.string "tag_sequence4deplexing", limit: 30, comment: "Tag sequence used for deplexing the lane, common suffix might have been truncated"
    t.integer "actual_forward_read_length", limit: 2, comment: "Actual forward read length, bp", unsigned: true
    t.integer "actual_reverse_read_length", limit: 2, comment: "Actual reverse read length, bp", unsigned: true
    t.integer "indexing_read_length", limit: 2, comment: "Indexing read length, bp", unsigned: true
    t.float "tag_decode_percent", unsigned: true
    t.integer "tag_decode_count", unsigned: true
    t.integer "insert_size_quartile1", limit: 2, unsigned: true
    t.integer "insert_size_quartile3", limit: 2, unsigned: true
    t.integer "insert_size_median", limit: 2, unsigned: true
    t.integer "insert_size_num_modes", limit: 2, unsigned: true
    t.float "insert_size_normal_fit_confidence", unsigned: true
    t.float "gc_percent_forward_read", unsigned: true
    t.float "gc_percent_reverse_read", unsigned: true
    t.float "sequence_mismatch_percent_forward_read", unsigned: true
    t.float "sequence_mismatch_percent_reverse_read", unsigned: true
    t.float "adapters_percent_forward_read", unsigned: true
    t.float "adapters_percent_reverse_read", unsigned: true
    t.string "ref_match1_name", limit: 100
    t.float "ref_match1_percent"
    t.string "ref_match2_name", limit: 100
    t.float "ref_match2_percent"
    t.integer "q20_yield_kb_forward_read", unsigned: true
    t.integer "q20_yield_kb_reverse_read", unsigned: true
    t.integer "q30_yield_kb_forward_read", unsigned: true
    t.integer "q30_yield_kb_reverse_read", unsigned: true
    t.integer "q40_yield_kb_forward_read", unsigned: true
    t.integer "q40_yield_kb_reverse_read", unsigned: true
    t.bigint "num_reads", unsigned: true
    t.float "percent_mapped"
    t.float "percent_duplicate"
    t.float "chimeric_reads_percent", comment: "mate_mapped_defferent_chr_5 as percentage of all", unsigned: true
    t.float "human_percent_mapped"
    t.float "human_percent_duplicate"
    t.string "genotype_sample_name_match", limit: 8
    t.string "genotype_sample_name_relaxed_match", limit: 8
    t.float "genotype_mean_depth"
    t.float "mean_bait_coverage", unsigned: true
    t.float "on_bait_percent", unsigned: true
    t.float "on_or_near_bait_percent", unsigned: true
    t.float "verify_bam_id_average_depth", unsigned: true
    t.float "verify_bam_id_score", unsigned: true
    t.integer "verify_bam_id_snp_count", unsigned: true
    t.float "rna_exonic_rate", comment: "Exonic Rate is the fraction mapping within exons", unsigned: true
    t.float "rna_percent_end_2_reads_sense", comment: "Percentage of intragenic End 2 reads that were sequenced in the sense direction.", unsigned: true
    t.float "rna_rrna_rate", comment: "rRNA Rate is per total reads", unsigned: true
    t.integer "rna_genes_detected", comment: "Number of genes detected with at least 5 reads.", unsigned: true
    t.float "rna_norm_3_prime_coverage", comment: "3 prime n-based normalization: n is the transcript length at that end; norm is the ratio between the coverage at the 3 prime end and the average coverage of the full transcript, averaged over all transcripts", unsigned: true
    t.float "rna_norm_5_prime_coverage", comment: "5 prime n-based normalization: n is the transcript length at that end; norm is the ratio between the coverage at the 5 prime end and the average coverage of the full transcript, averaged over all transcripts", unsigned: true
    t.float "rna_intronic_rate", comment: "Intronic rate is the fraction mapping within introns", unsigned: true
    t.integer "rna_transcripts_detected", comment: "Number of transcripts detected with at least 5 reads", unsigned: true
    t.float "rna_globin_percent_tpm", comment: "Percentage of globin genes TPM (transcripts per million) detected", unsigned: true
    t.float "rna_mitochondrial_percent_tpm", comment: "Percentage of mitochondrial genes TPM (transcripts per million) detected", unsigned: true
    t.float "gbs_call_rate", comment: "The GbS call rate is the fraction of loci called on the relevant primer panel", unsigned: true
    t.float "gbs_pass_rate", comment: "The GbS pass rate is the fraction of loci called and passing filters on the relevant primer panel", unsigned: true
    t.float "nrd_percent", comment: "Percent of non-reference discordance"
    t.string "target_filter", limit: 30, comment: "Filter used to produce the target stats file"
    t.bigint "target_length", comment: "The total length of the target regions", unsigned: true
    t.bigint "target_mapped_reads", comment: "The number of mapped reads passing the target filter", unsigned: true
    t.bigint "target_proper_pair_mapped_reads", comment: "The number of proper pair mapped reads passing the target filter", unsigned: true
    t.bigint "target_mapped_bases", comment: "The number of mapped bases passing the target filter", unsigned: true
    t.integer "target_coverage_threshold", comment: "The coverage threshold used in the target perc target greater than depth calculation"
    t.float "target_percent_gt_coverage_threshold", comment: "The percentage of the target covered at greater than the depth specified"
    t.integer "target_autosome_coverage_threshold", comment: "The coverage threshold used in the perc target autosome greater than depth calculation"
    t.float "target_autosome_percent_gt_coverage_threshold", comment: "The percentage of the target autosome covered at greater than the depth specified"
    t.index ["id_iseq_flowcell_tmp"], name: "iseq_pr_metrics_flc_fk"
    t.index ["id_iseq_product"], name: "iseq_pr_metrics_product_unique", unique: true
    t.index ["id_run", "position", "tag_index"], name: "iseq_pm_fcid_run_pos_tag_index"
  end

  create_table "iseq_run_lane_metrics", primary_key: ["id_run", "position"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "flowcell_barcode", limit: 15, comment: "Manufacturer flowcell barcode or other identifier as recorded by NPG"
    t.integer "id_run", null: false, comment: "NPG run identifier", unsigned: true
    t.integer "position", limit: 2, null: false, comment: "Flowcell lane number", unsigned: true
    t.datetime "last_changed", default: -> { "CURRENT_TIMESTAMP" }, comment: "Date this record was created or changed"
    t.boolean "qc_seq", comment: "Sequencing lane level QC outcome, a result of either manual or automatic assessment by core"
    t.string "instrument_name", limit: 32
    t.string "instrument_external_name", limit: 10, comment: "Name assigned to the instrument by the manufacturer"
    t.string "instrument_model", limit: 64
    t.string "instrument_side", limit: 1, comment: "Illumina instrument side (A or B), if appropriate"
    t.string "workflow_type", limit: 20, comment: "Illumina instrument workflow type"
    t.integer "paired_read", limit: 1, default: 0, null: false, unsigned: true
    t.integer "cycles", null: false, unsigned: true
    t.integer "cancelled", limit: 1, default: 0, null: false, comment: "Boolen flag to indicate whether the run was cancelled", unsigned: true
    t.datetime "run_pending", comment: "Timestamp of run pending status"
    t.datetime "run_complete", comment: "Timestamp of run complete status"
    t.datetime "qc_complete", comment: "Timestamp of qc complete status"
    t.bigint "pf_cluster_count", unsigned: true
    t.bigint "raw_cluster_count", unsigned: true
    t.float "raw_cluster_density", limit: 53, unsigned: true
    t.float "pf_cluster_density", limit: 53, unsigned: true
    t.bigint "pf_bases", unsigned: true
    t.integer "q20_yield_kb_forward_read", unsigned: true
    t.integer "q20_yield_kb_reverse_read", unsigned: true
    t.integer "q30_yield_kb_forward_read", unsigned: true
    t.integer "q30_yield_kb_reverse_read", unsigned: true
    t.integer "q40_yield_kb_forward_read", unsigned: true
    t.integer "q40_yield_kb_reverse_read", unsigned: true
    t.float "tags_decode_percent", unsigned: true
    t.float "tags_decode_cv", unsigned: true
    t.float "unexpected_tags_percent", comment: "tag0_perfect_match_reads as a percentage of total_lane_reads", unsigned: true
    t.float "tag_hops_percent", comment: "Percentage tag hops for dual index runs", unsigned: true
    t.float "tag_hops_power", comment: "Power to detect tag hops for dual index runs", unsigned: true
    t.integer "run_priority", limit: 1, comment: "Sequencing lane level run priority, a result of either manual or default value set by core"
    t.bigint "interop_cluster_count_total", comment: "Total cluster count for this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_count_mean", limit: 53, comment: "Total cluster count, mean value over tiles of this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_count_stdev", limit: 53, comment: "Standard deviation value for interop_cluster_count_mean", unsigned: true
    t.bigint "interop_cluster_count_pf_total", comment: "Purity-filtered cluster count for this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_count_pf_mean", limit: 53, comment: "Purity-filtered cluster count, mean value over tiles of this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_count_pf_stdev", limit: 53, comment: "Standard deviation value for interop_cluster_count_pf_mean", unsigned: true
    t.float "interop_cluster_density_mean", limit: 53, comment: "Cluster density, mean value over tiles of this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_density_stdev", limit: 53, comment: "Standard deviation value for interop_cluster_density_mean", unsigned: true
    t.float "interop_cluster_density_pf_mean", limit: 53, comment: "Purity-filtered cluster density, mean value over tiles of this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_density_pf_stdev", limit: 53, comment: "Standard deviation value for interop_cluster_density_pf_mean", unsigned: true
    t.float "interop_cluster_pf_mean", comment: " Percent of purity-filtered clusters, mean value over tiles of this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_cluster_pf_stdev", comment: "Standard deviation value for interop_cluster_pf_mean", unsigned: true
    t.float "interop_occupied_mean", comment: "Percent of occupied flowcell wells, a mean value over tiles of this lane (derived from Illumina InterOp files)", unsigned: true
    t.float "interop_occupied_stdev", comment: "Standard deviation value for interop_occupied_mean", unsigned: true
    t.index ["cancelled", "run_complete"], name: "iseq_rlm_cancelled_and_run_complete_index"
    t.index ["cancelled", "run_pending"], name: "iseq_rlm_cancelled_and_run_pending_index"
    t.index ["id_run"], name: "iseq_rlmm_id_run_index"
  end

  create_table "iseq_run_status", primary_key: "id_run_status", id: :integer, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id_run", null: false, comment: "NPG run identifier", unsigned: true
    t.datetime "date", null: false, comment: "Status timestamp"
    t.integer "id_run_status_dict", null: false, comment: "Status identifier, see iseq_run_status_dict.id_run_status_dict", unsigned: true
    t.boolean "iscurrent", null: false, comment: "Boolean flag, 1 is the status is current, 0 otherwise"
    t.index ["id_run"], name: "id_run_status_id_run"
    t.index ["id_run_status_dict"], name: "iseq_run_status_rsd_fk"
  end

  create_table "iseq_run_status_dict", primary_key: "id_run_status_dict", id: :integer, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "description", limit: 64, null: false
    t.integer "iscurrent", limit: 1, null: false, unsigned: true
    t.integer "temporal_index", limit: 2, unsigned: true
    t.index ["description"], name: "iseq_run_status_dict_description_index"
  end

  create_table "lighthouse_sample", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "mongodb_id", comment: "Auto-generated id from MongoDB"
    t.string "root_sample_id", null: false, comment: "Id for this sample provided by the Lighthouse lab"
    t.string "cog_uk_id", comment: "Consortium-wide id, generated by Sanger on import to LIMS"
    t.string "rna_id", null: false, comment: "Lighthouse lab-provided id made up of plate barcode and well"
    t.string "plate_barcode", comment: "Barcode of plate sample arrived in, from rna_id"
    t.string "coordinate", comment: "Well position from plate sample arrived in, from rna_id"
    t.string "result", null: false, comment: "Covid-19 test result from the Lighthouse lab"
    t.string "date_tested_string", comment: "When the covid-19 test was carried out by the Lighthouse lab"
    t.datetime "date_tested", comment: "date_tested_string in date format"
    t.string "source", comment: "Lighthouse centre that the sample came from"
    t.string "lab_id", comment: "Id of the lab, within the Lighthouse centre"
    t.string "ch1_target"
    t.string "ch1_result"
    t.decimal "ch1_cq", precision: 11, scale: 8
    t.string "ch2_target"
    t.string "ch2_result"
    t.decimal "ch2_cq", precision: 11, scale: 8
    t.string "ch3_target"
    t.string "ch3_result"
    t.decimal "ch3_cq", precision: 11, scale: 8
    t.string "ch4_target"
    t.string "ch4_result"
    t.decimal "ch4_cq", precision: 11, scale: 8
    t.boolean "filtered_positive", comment: "Filtered positive result value"
    t.string "filtered_positive_version", comment: "Filtered positive version"
    t.datetime "filtered_positive_timestamp", comment: "Filtered positive timestamp"
    t.string "lh_sample_uuid", limit: 36, comment: "Sample uuid created in crawler"
    t.string "lh_source_plate_uuid", limit: 36, comment: "Source plate uuid created in crawler"
    t.datetime "created_at", comment: "When this record was inserted"
    t.datetime "updated_at", comment: "When this record was last updated"
    t.boolean "must_sequence", comment: "PAM provided value whether sample is of high importance"
    t.boolean "preferentially_sequence", comment: "PAM provided value whether sample is important"
    t.boolean "is_current", default: false, null: false, comment: "Identifies if this sample has the most up to date information for the same rna_id"
    t.index ["cog_uk_id"], name: "index_lighthouse_sample_on_cog_uk_id"
    t.index ["date_tested"], name: "index_lighthouse_sample_on_date_tested"
    t.index ["filtered_positive"], name: "index_lighthouse_sample_on_filtered_positive"
    t.index ["lh_sample_uuid"], name: "index_lighthouse_sample_on_lh_sample_uuid", unique: true
    t.index ["mongodb_id"], name: "index_lighthouse_sample_on_mongodb_id", unique: true
    t.index ["plate_barcode", "created_at"], name: "index_lighthouse_sample_on_plate_barcode_and_created_at"
    t.index ["result"], name: "index_lighthouse_sample_on_result"
    t.index ["rna_id"], name: "index_lighthouse_sample_on_rna_id"
    t.index ["root_sample_id", "rna_id", "result"], name: "index_lighthouse_sample_on_root_sample_id_and_rna_id_and_result", unique: true
  end

  create_table "oseq_flowcell", primary_key: "id_oseq_flowcell_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_flowcell_lims", null: false, comment: "LIMs-specific flowcell id"
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.string "experiment_name", null: false, comment: "The name of the experiment, eg. The lims generated run id"
    t.string "instrument_name", null: false, comment: "The name of the instrument on which the sample was run"
    t.integer "instrument_slot", null: false, comment: "The numeric identifier of the slot on which the sample was run"
    t.string "pipeline_id_lims", comment: "LIMs-specific pipeline identifier that unambiguously defines library type"
    t.string "requested_data_type", comment: "The type of data produced by sequencing, eg. basecalls only"
    t.datetime "deleted_at", comment: "Timestamp of any flowcell destruction"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.string "tag_identifier", comment: "Position of the first tag within the tag group"
    t.string "tag_sequence", comment: "Sequence of the first tag"
    t.string "tag_set_id_lims", comment: "LIMs-specific identifier of the tag set for the first tag"
    t.string "tag_set_name", comment: "WTSI-wide tag set name for the first tag"
    t.string "tag2_identifier", comment: "Position of the second tag within the tag group"
    t.string "tag2_sequence", comment: "Sequence of the second tag"
    t.string "tag2_set_id_lims", comment: "LIMs-specific identifier of the tag set for the second tag"
    t.string "tag2_set_name", comment: "WTSI-wide tag set name for the second tag"
    t.index ["id_sample_tmp"], name: "fk_oseq_flowcell_to_sample"
    t.index ["id_study_tmp"], name: "fk_oseq_flowcell_to_study"
  end

  create_table "pac_bio_product_metrics", primary_key: "id_pac_bio_pr_metrics_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "A linking table for the pac_bio_run and pac_bio_run_well_metrics tables with a potential for adding per-product QC data", force: :cascade do |t|
    t.integer "id_pac_bio_rw_metrics_tmp", null: false, comment: "PacBio run well metrics id, see \"pac_bio_run_well_metrics.id_pac_bio_rw_metrics_tmp\""
    t.integer "id_pac_bio_tmp", comment: "PacBio run id, see \"pac_bio_run.id_pac_bio_tmp\""
    t.index ["id_pac_bio_rw_metrics_tmp"], name: "pac_bio_pr_metrics_to_rwm_fk"
    t.index ["id_pac_bio_tmp"], name: "pac_bio_pr_metrics_to_run_fk"
  end

  create_table "pac_bio_run", primary_key: "id_pac_bio_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
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
    t.string "tag2_sequence", limit: 30
    t.string "tag2_set_id_lims", limit: 20
    t.string "tag2_set_name", limit: 100
    t.string "tag2_identifier", limit: 30
    t.string "plate_barcode", null: false, comment: "The human readable barcode for the plate loaded onto the machine"
    t.string "plate_uuid_lims", limit: 36, null: false, comment: "The plate uuid"
    t.string "well_label", null: false, comment: "The well identifier for the plate, A1-H12"
    t.string "well_uuid_lims", limit: 36, null: false, comment: "The well uuid"
    t.string "pac_bio_library_tube_id_lims", null: false, comment: "LIMS specific identifier for originating library tube"
    t.string "pac_bio_library_tube_uuid", null: false, comment: "The uuid for the originating library tube"
    t.string "pac_bio_library_tube_name", null: false, comment: "The name of the originating library tube"
    t.integer "pac_bio_library_tube_legacy_id", comment: "Legacy library_id for backwards compatibility."
    t.datetime "library_created_at", comment: "Timestamp of library creation"
    t.string "pac_bio_run_name", comment: "Name of the run"
    t.string "pipeline_id_lims", limit: 60, comment: "LIMS-specific pipeline identifier that unambiguously defines library type (eg. Sequel-v1, IsoSeq-v1)"
    t.virtual "comparable_tag_identifier", type: :string, as: "ifnull(`tag_identifier`,-(1))"
    t.virtual "comparable_tag2_identifier", type: :string, as: "ifnull(`tag2_identifier`,-(1))"
    t.index ["id_pac_bio_run_lims", "well_label", "comparable_tag_identifier", "comparable_tag2_identifier"], name: "unique_pac_bio_entry", unique: true
    t.index ["id_sample_tmp"], name: "fk_pac_bio_run_to_sample"
    t.index ["id_study_tmp"], name: "fk_pac_bio_run_to_study"
  end

  create_table "pac_bio_run_well_metrics", primary_key: "id_pac_bio_rw_metrics_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "Status and run information by well and some basic QC data from SMRT Link", force: :cascade do |t|
    t.string "pac_bio_run_name", null: false, collation: "utf8_unicode_ci", comment: "Lims specific identifier for the pacbio run"
    t.string "well_label", null: false, collation: "utf8_unicode_ci", comment: "The well identifier for the plate, A1-H12"
    t.string "instrument_type", limit: 32, null: false, collation: "utf8_unicode_ci", comment: "The instrument type e.g. Sequel"
    t.string "instrument_name", limit: 32, collation: "utf8_unicode_ci", comment: "The instrument name e.g. SQ54097"
    t.string "chip_type", limit: 32, collation: "utf8_unicode_ci", comment: "The chip type e.g. 8mChip"
    t.string "ts_run_name", limit: 32, collation: "utf8_unicode_ci", comment: "The PacBio run name"
    t.string "movie_name", limit: 32, collation: "utf8_unicode_ci", comment: "The PacBio movie name"
    t.string "ccs_execution_mode", limit: 32, collation: "utf8_unicode_ci", comment: "The PacBio ccs exection mode e.g. OnInstument, OffInstument or None"
    t.datetime "run_start", comment: "Timestamp of run started"
    t.datetime "run_complete", comment: "Timestamp of run complete"
    t.string "run_status", limit: 32, comment: "Last recorded status, primarily to explain runs not completed."
    t.datetime "well_start", comment: "Timestamp of well started"
    t.datetime "well_complete", comment: "Timestamp of well complete"
    t.string "well_status", limit: 32, comment: "Last recorded status, primarily to explain wells not completed."
    t.string "chemistry_sw_version", limit: 32, collation: "utf8_unicode_ci", comment: "The PacBio chemistry software version"
    t.string "instrument_sw_version", limit: 32, collation: "utf8_unicode_ci", comment: "The PacBio instrument software version"
    t.string "primary_analysis_sw_version", limit: 32, collation: "utf8_unicode_ci", comment: "The PacBio primary analysis software version"
    t.bigint "polymerase_read_bases", comment: "Calculated by multiplying the number of productive (P1) ZMWs by the mean polymerase read length", unsigned: true
    t.integer "polymerase_num_reads", comment: "The number of polymerase reads", unsigned: true
    t.integer "polymerase_read_length_mean", comment: "The mean high-quality read length of all polymerase reads", unsigned: true
    t.integer "polymerase_read_length_n50", comment: "Fifty percent of the trimmed read length of all polymerase reads are longer than this value", unsigned: true
    t.integer "insert_length_mean", comment: "The average subread length, considering only the longest subread from each ZMW", unsigned: true
    t.integer "insert_length_n50", comment: "Fifty percent of the subreads are longer than this value when considering only the longest subread from each ZMW", unsigned: true
    t.bigint "unique_molecular_bases", comment: "The unique molecular yield in bp", unsigned: true
    t.integer "productive_zmws_num", comment: "Number of productive ZMWs", unsigned: true
    t.integer "p0_num", comment: "Number of empty ZMWs with no high quality read detected", unsigned: true
    t.integer "p1_num", comment: "Number of ZMWs with a high quality read detected", unsigned: true
    t.integer "p2_num", comment: "Number of other ZMWs, signal detected but no high quality read", unsigned: true
    t.float "adapter_dimer_percent", comment: "The percentage of pre-filter ZMWs which have observed inserts of 0-10 bp", unsigned: true
    t.float "short_insert_percent", comment: "The percentage of pre-filter ZMWs which have observed inserts of 11-100 bp", unsigned: true
    t.index ["pac_bio_run_name", "well_label"], name: "pac_bio_metrics_run_well", unique: true
  end

  create_table "psd_sample_compounds_components", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", comment: "A join table owned by PSD to associate compound samples with their component samples.", force: :cascade do |t|
    t.integer "compound_id_sample_tmp", null: false, comment: "The warehouse ID of the compound sample in the association."
    t.integer "component_id_sample_tmp", null: false, comment: "The warehouse ID of the component sample in the association."
    t.datetime "last_updated", null: false, comment: "Timestamp of last update."
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update."
  end

  create_table "qc_result", primary_key: "id_qc_result_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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
    t.datetime "date_created", null: false, comment: "The date the qc_result was first created in SS"
    t.datetime "last_updated", null: false, comment: "The date the qc_result was last updated in SS"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.index ["id_library_lims"], name: "qc_result_id_library_lims_index"
    t.index ["id_qc_result_lims", "id_lims"], name: "lookup_index"
    t.index ["id_sample_tmp"], name: "fk_qc_result_to_sample"
  end

  create_table "sample", primary_key: "id_sample_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE"
    t.string "uuid_sample_lims", limit: 36, comment: "LIMS-specific sample uuid"
    t.string "id_sample_lims", limit: 20, null: false, comment: "LIMS-specific sample identifier"
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.datetime "deleted_at", comment: "Timestamp of sample deletion"
    t.datetime "created", comment: "Timestamp of sample creation"
    t.string "name"
    t.string "reference_genome"
    t.string "organism"
    t.string "accession_number", limit: 50
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
    t.datetime "date_of_consent_withdrawn"
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

  create_table "samples_extraction_activity", primary_key: "id_activity_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_activity_lims", null: false, comment: "LIMs-specific activity id"
    t.integer "id_sample_tmp", null: false, comment: "Sample id, see \"sample.id_sample_tmp\"", unsigned: true
    t.string "activity_type", null: false, comment: "The type of the activity performed"
    t.string "instrument", null: false, comment: "The name of the instrument used to perform the activity"
    t.string "kit_barcode", null: false, comment: "The barcode of the kit used to perform the activity"
    t.string "kit_type", null: false, comment: "The type of kit used to perform the activity"
    t.string "input_barcode", null: false, comment: "The barcode of the labware (eg. plate or tube) at the begining of the activity"
    t.string "output_barcode", null: false, comment: "The barcode of the labware (eg. plate or tube)  at the end of the activity"
    t.string "user", null: false, comment: "The name of the user who was most recently associated with the activity"
    t.datetime "last_updated", null: false, comment: "Timestamp of last change to activity"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.datetime "completed_at", null: false, comment: "Timestamp of activity completion"
    t.datetime "deleted_at", comment: "Timestamp of any activity removal"
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier"
    t.index ["id_activity_lims"], name: "index_samples_extraction_activity_on_id_activity_lims"
    t.index ["id_sample_tmp"], name: "fk_rails_bbdd0468f0"
  end

  create_table "stock_resource", primary_key: "id_stock_resource_tmp", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.datetime "created", null: false, comment: "Timestamp of initial registration of stock in LIMS"
    t.datetime "deleted_at", comment: "Timestamp of initial registration of deletion in parent LIMS. NULL if not deleted."
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
    t.index ["labware_human_barcode"], name: "index_stock_resource_on_labware_human_barcode"
  end

  create_table "study", primary_key: "id_study_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "id_lims", limit: 10, null: false, comment: "LIM system identifier, e.g. GCLP-CLARITY, SEQSCAPE"
    t.string "uuid_study_lims", limit: 36, comment: "LIMS-specific study uuid"
    t.string "id_study_lims", limit: 20, null: false, comment: "LIMS-specific study identifier"
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
    t.datetime "recorded_at", null: false, comment: "Timestamp of warehouse update"
    t.datetime "deleted_at", comment: "Timestamp of study deletion"
    t.datetime "created", comment: "Timestamp of study creation"
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

  create_table "study_users", primary_key: "id_study_users_tmp", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id_study_tmp", null: false, comment: "Study id, see \"study.id_study_tmp\"", unsigned: true
    t.datetime "last_updated", null: false, comment: "Timestamp of last update"
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
  add_foreign_key "iseq_external_product_components", "iseq_external_product_metrics", column: "id_iseq_product_ext", primary_key: "id_iseq_product", name: "id_iseq_product_ext_digest_fk"
  add_foreign_key "iseq_flowcell", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "iseq_flowcell_sample_fk"
  add_foreign_key "iseq_flowcell", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "iseq_flowcell_study_fk"
  add_foreign_key "iseq_product_ampliconstats", "iseq_product_metrics", column: "id_iseq_product", primary_key: "id_iseq_product", name: "iseq_pastats_prm_fk"
  add_foreign_key "iseq_product_components", "iseq_product_metrics", column: "id_iseq_pr_component_tmp", primary_key: "id_iseq_pr_metrics_tmp", name: "iseq_pr_comp_pr_comp_fk"
  add_foreign_key "iseq_product_components", "iseq_product_metrics", column: "id_iseq_pr_tmp", primary_key: "id_iseq_pr_metrics_tmp", name: "iseq_pr_comp_pr_fk", on_delete: :cascade
  add_foreign_key "iseq_product_metrics", "iseq_flowcell", column: "id_iseq_flowcell_tmp", primary_key: "id_iseq_flowcell_tmp", name: "iseq_pr_metrics_flc_fk", on_delete: :nullify
  add_foreign_key "iseq_product_metrics", "iseq_run_lane_metrics", column: "id_run", primary_key: "id_run", name: "iseq_pr_metrics_lm_fk", on_delete: :cascade
  add_foreign_key "iseq_product_metrics", "iseq_run_lane_metrics", column: "position", primary_key: "position", name: "iseq_pr_metrics_lm_fk", on_delete: :cascade
  add_foreign_key "iseq_run_status", "iseq_run_status_dict", column: "id_run_status_dict", primary_key: "id_run_status_dict", name: "iseq_run_status_rsd_fk"
  add_foreign_key "oseq_flowcell", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_oseq_flowcell_to_sample"
  add_foreign_key "oseq_flowcell", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_oseq_flowcell_to_study"
  add_foreign_key "pac_bio_product_metrics", "pac_bio_run", column: "id_pac_bio_tmp", primary_key: "id_pac_bio_tmp", name: "pac_bio_product_metrics_to_run_fk", on_delete: :nullify
  add_foreign_key "pac_bio_product_metrics", "pac_bio_run_well_metrics", column: "id_pac_bio_rw_metrics_tmp", primary_key: "id_pac_bio_rw_metrics_tmp", name: "pac_bio_product_metrics_to_rwm_fk", on_delete: :cascade
  add_foreign_key "pac_bio_run", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_pac_bio_run_to_sample"
  add_foreign_key "pac_bio_run", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_pac_bio_run_to_study"
  add_foreign_key "qc_result", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_qc_result_to_sample"
  add_foreign_key "samples_extraction_activity", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp"
  add_foreign_key "stock_resource", "sample", column: "id_sample_tmp", primary_key: "id_sample_tmp", name: "fk_stock_resource_to_sample"
  add_foreign_key "stock_resource", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "fk_stock_resource_to_study"
  add_foreign_key "study_users", "study", column: "id_study_tmp", primary_key: "id_study_tmp", name: "study_users_study_fk"
end
