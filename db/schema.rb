# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "flgen_plate", :primary_key => "id_flgen_plate_tmp", :force => true do |t|
    t.integer  "id_sample_tmp",                     :null => false
    t.integer  "id_study_tmp",                      :null => false
    t.string   "cost_code",           :limit => 20, :null => false
    t.string   "id_lims",             :limit => 10, :null => false
    t.datetime "last_updated",                      :null => false
    t.integer  "plate_barcode",                     :null => false
    t.integer  "plate_barcode_lims",                :null => false
    t.string   "plate_uuid_lims",     :limit => 36
    t.string   "plate_id_lims",       :limit => 20, :null => false
    t.integer  "plate_size",          :limit => 2
    t.integer  "plate_size_occupied", :limit => 2
    t.string   "well_label",          :limit => 10, :null => false
    t.string   "well_uuid_lims",      :limit => 36
    t.boolean  "qc_state"
  end

  add_index "flgen_plate", ["id_sample_tmp"], :name => "flgen_plate_sample_fk"
  add_index "flgen_plate", ["id_study_tmp"], :name => "flgen_plate_study_fk"

  create_table "iseq_flowcell", :primary_key => "id_iseq_flowcell_tmp", :force => true do |t|
    t.datetime "last_updated",                                                :null => false
    t.integer  "id_sample_tmp",                                               :null => false
    t.integer  "id_study_tmp",                                                :null => false
    t.string   "cost_code",                  :limit => 20,                    :null => false
    t.boolean  "is_r_and_d",                               :default => false, :null => false
    t.string   "id_lims",                    :limit => 10,                    :null => false
    t.integer  "priority",                   :limit => 2,  :default => 1
    t.boolean  "manual_qc"
    t.boolean  "external_release"
    t.string   "flowcell_barcode",           :limit => 15
    t.string   "flowcell_id",                :limit => 20,                    :null => false
    t.integer  "position",                   :limit => 2,                     :null => false
    t.string   "entity_type",                :limit => 30,                    :null => false
    t.string   "entity_id_lims",             :limit => 20,                    :null => false
    t.integer  "num_target_components",      :limit => 2,                     :null => false
    t.integer  "tag_index",                  :limit => 2
    t.string   "tag_sequence",               :limit => 30
    t.string   "tag_set_id_lims",            :limit => 20
    t.string   "tag_set_name",               :limit => 50
    t.boolean  "is_spiked",                                :default => false, :null => false
    t.string   "pipeline_id_lims",           :limit => 50,                    :null => false
    t.string   "bait_name",                  :limit => 50
    t.integer  "requested_insert_size_from"
    t.integer  "requested_insert_size_to"
    t.integer  "forward_read_length",        :limit => 2
    t.integer  "reverse_read_length",        :limit => 2
  end

  add_index "iseq_flowcell", ["id_sample_tmp"], :name => "iseq_flowcell_sample_fk"
  add_index "iseq_flowcell", ["id_study_tmp"], :name => "iseq_flowcell_study_fk"

  create_table "iseq_product_metrics", :primary_key => "id_iseq_pr_metrics_tmp", :force => true do |t|
    t.integer "id_iseq_lane_metrics_tmp",                              :null => false
    t.integer "id_iseq_flowcell_tmp"
    t.integer "id_run",                                                :null => false
    t.integer "position",                               :limit => 2,   :null => false
    t.integer "tag_index",                              :limit => 2
    t.string  "tag_sequence",                           :limit => 30
    t.float   "tag_decode_percent",                     :limit => 5
    t.integer "tag_decode_count"
    t.integer "insert_size_quartile1",                  :limit => 2
    t.integer "insert_size_quartile3",                  :limit => 2
    t.integer "insert_size_median",                     :limit => 2
    t.float   "gc_percent_forward_read",                :limit => 5
    t.float   "gc_percent_reverse_read",                :limit => 5
    t.float   "sequence_mismatch_percent_forward_read", :limit => 4
    t.float   "sequence_mismatch_percent_reverse_read", :limit => 4
    t.float   "adapters_percent_forward_read",          :limit => 5
    t.float   "adapters_percent_reverse_read",          :limit => 5
    t.string  "contaminants_scan_hit1_name",            :limit => 50
    t.float   "contaminants_scan_hit1_score",           :limit => 6
    t.string  "contaminants_scan_hit2_name",            :limit => 50
    t.float   "contaminants_scan_hit2_score",           :limit => 6
    t.string  "ref_match1_name",                        :limit => 100
    t.float   "ref_match1_percent",                     :limit => 5
    t.string  "ref_match2_name",                        :limit => 100
    t.float   "ref_match2_percent",                     :limit => 5
    t.integer "q20_yield_kb_forward_read"
    t.integer "q20_yield_kb_reverse_read"
    t.integer "q30_yield_kb_forward_read"
    t.integer "q30_yield_kb_reverse_read"
    t.integer "q40_yield_kb_forward_read"
    t.integer "q40_yield_kb_reverse_read"
    t.integer "bam_num_reads",                          :limit => 8
    t.float   "bam_percent_mapped_target",              :limit => 5
    t.float   "bam_percent_duplicate_target",           :limit => 5
    t.float   "bam_percent_mapped_human",               :limit => 5
    t.float   "bam_percent_duplicate_human",            :limit => 5
    t.string  "human_split_type",                       :limit => 5
    t.float   "bam_percent_mapped_spike",               :limit => 5
    t.float   "bam_percent_duplicate_spike",            :limit => 5
    t.string  "genotype_sample_name_match",             :limit => 8
    t.string  "genotype_sample_name_relaxed_match",     :limit => 8
    t.float   "genotype_mean_depth",                    :limit => 7
    t.float   "mean_bait_coverage",                     :limit => 6
    t.float   "on_bait_percent",                        :limit => 5
    t.float   "on_or_near_bait_percent",                :limit => 5
    t.integer "verify_bam_id_average_depth",            :limit => 2
    t.float   "verify_bam_id_score",                    :limit => 7
  end

  add_index "iseq_product_metrics", ["id_iseq_flowcell_tmp"], :name => "iseq_pr_metrics_flc_fk"
  add_index "iseq_product_metrics", ["id_iseq_lane_metrics_tmp"], :name => "iseq_pr_metrics_lm_fk"
  add_index "iseq_product_metrics", ["id_run", "position", "tag_index"], :name => "iseq_pm_fcid_run_pos_tag_index"
  add_index "iseq_product_metrics", ["id_run", "position"], :name => "iseq_pm_run_pos_index"
  add_index "iseq_product_metrics", ["id_run"], :name => "iseq_pm_run_index"

  create_table "iseq_run_lane_metrics", :primary_key => "id_iseq_lane_metrics_tmp", :force => true do |t|
    t.integer  "id_iseq_flowcell_tmp"
    t.string   "flowcell_barcode",                       :limit => 15
    t.integer  "id_run",                                                                   :null => false
    t.integer  "position",                               :limit => 2,                      :null => false
    t.string   "instrument_name",                        :limit => 32
    t.string   "instrument_model",                       :limit => 64
    t.boolean  "paired_read",                                           :default => false, :null => false
    t.integer  "forward_read_length",                    :limit => 2
    t.integer  "reverse_read_length",                    :limit => 2
    t.integer  "indexing_read_length",                   :limit => 2
    t.boolean  "indexed_run",                                                              :null => false
    t.integer  "cycles",                                                                   :null => false
    t.boolean  "cancelled",                                             :default => false, :null => false
    t.datetime "run_pending"
    t.datetime "run_complete"
    t.datetime "qc_complete"
    t.integer  "pf_cluster_count",                       :limit => 8
    t.integer  "raw_cluster_count",                      :limit => 8
    t.float    "raw_cluster_density",                    :limit => 12
    t.float    "pf_cluster_density",                     :limit => 12
    t.integer  "pf_bases",                               :limit => 8
    t.integer  "q20_yield_kb_forward_read"
    t.integer  "q20_yield_kb_reverse_read"
    t.integer  "q30_yield_kb_forward_read"
    t.integer  "q30_yield_kb_reverse_read"
    t.integer  "q40_yield_kb_forward_read"
    t.integer  "q40_yield_kb_reverse_read"
    t.float    "tags_decode_percent",                    :limit => 5
    t.float    "tags_decode_cv",                         :limit => 6
    t.float    "adapters_percent_forward_read",          :limit => 5
    t.float    "adapters_percent_reverse_read",          :limit => 5
    t.integer  "insert_size_quartile1",                  :limit => 2
    t.integer  "insert_size_quartile3",                  :limit => 2
    t.integer  "insert_size_median",                     :limit => 2
    t.string   "ref_match1_name",                        :limit => 100
    t.float    "ref_match1_percent",                     :limit => 5
    t.string   "ref_match2_name",                        :limit => 100
    t.float    "ref_match2_percent",                     :limit => 5
    t.float    "gc_percent_forward_read",                :limit => 5
    t.float    "gc_percent_reverse_read",                :limit => 5
    t.float    "sequence_mismatch_percent_forward_read", :limit => 4
    t.float    "sequence_mismatch_percent_reverse_read", :limit => 4
  end

  add_index "iseq_run_lane_metrics", ["cancelled", "run_complete"], :name => "iseq_rlm_cancelled_and_run_complete_index"
  add_index "iseq_run_lane_metrics", ["cancelled", "run_pending"], :name => "iseq_rlm_cancelled_and_run_pending_index"
  add_index "iseq_run_lane_metrics", ["id_iseq_flowcell_tmp", "id_run", "position"], :name => "iseq_rlm_fcid_run_pos", :unique => true
  add_index "iseq_run_lane_metrics", ["id_run", "position"], :name => "iseq_rlm_run_position_index", :unique => true
  add_index "iseq_run_lane_metrics", ["id_run"], :name => "iseq_rlmm_id_run_index"

  create_table "iseq_run_status", :primary_key => "id_run_status", :force => true do |t|
    t.integer  "id_run",             :null => false
    t.datetime "date",               :null => false
    t.integer  "id_run_status_dict", :null => false
    t.integer  "id_user",            :null => false
    t.boolean  "iscurrent",          :null => false
  end

  add_index "iseq_run_status", ["id_run_status_dict"], :name => "iseq_run_status_rsd_fk"

  create_table "iseq_run_status_dict", :primary_key => "id_run_status_dict", :force => true do |t|
    t.string  "description",    :limit => 64, :null => false
    t.integer "iscurrent",      :limit => 1,  :null => false
    t.integer "temporal_index", :limit => 2
  end

  add_index "iseq_run_status_dict", ["description"], :name => "iseq_run_status_dict_description_index"

  create_table "sample", :primary_key => "id_sample_tmp", :force => true do |t|
    t.string   "id_lims",             :limit => 10,                    :null => false
    t.string   "uuid_sample_lims",    :limit => 36
    t.string   "id_sample_lims",      :limit => 20,                    :null => false
    t.datetime "last_updated",                                         :null => false
    t.string   "name"
    t.string   "reference_genome"
    t.string   "organism"
    t.string   "accession_number",    :limit => 50
    t.string   "common_name"
    t.text     "description"
    t.integer  "taxon_id"
    t.string   "father"
    t.string   "mother"
    t.string   "replicate"
    t.string   "ethnicity"
    t.string   "gender",              :limit => 20
    t.string   "cohort"
    t.string   "country_of_origin"
    t.string   "geographical_region"
    t.boolean  "control"
    t.string   "supplier_name"
    t.string   "public_name"
    t.string   "sample_visibility"
    t.string   "strain"
    t.boolean  "consent_withdrawn",                 :default => false, :null => false
    t.string   "donor_id"
  end

  add_index "sample", ["accession_number"], :name => "sample_accession_number_index"
  add_index "sample", ["id_sample_lims"], :name => "sample_id_sample_lims_index", :unique => true
  add_index "sample", ["name"], :name => "sample_name_index"
  add_index "sample", ["uuid_sample_lims"], :name => "sample_uuid_sample_lims_index"

  create_table "study", :primary_key => "id_study_tmp", :force => true do |t|
    t.string   "id_lims",                        :limit => 10,                    :null => false
    t.string   "uuid_study_lims",                :limit => 36
    t.string   "id_study_lims",                  :limit => 20,                    :null => false
    t.datetime "last_updated",                                                    :null => false
    t.string   "name"
    t.string   "reference_genome"
    t.boolean  "ethically_approved"
    t.string   "faculty_sponsor"
    t.string   "state",                          :limit => 50
    t.string   "study_type",                     :limit => 50
    t.text     "abstract"
    t.string   "abbreviation"
    t.string   "accession_number",               :limit => 50
    t.text     "description"
    t.string   "contains_human_dna"
    t.string   "contaminated_human_dna"
    t.string   "data_release_strategy"
    t.string   "data_release_sort_of_study"
    t.string   "ena_project_id"
    t.string   "study_title"
    t.string   "study_visibility"
    t.string   "ega_dac_accession_number"
    t.string   "array_express_accession_number"
    t.string   "ega_policy_accession_number"
    t.string   "data_release_timing"
    t.string   "data_release_delay_period"
    t.string   "data_release_delay_reason"
    t.boolean  "remove_x_and_autosomes",                       :default => false, :null => false
    t.boolean  "alignments_in_bam",                            :default => true,  :null => false
    t.boolean  "separate_y_chromosome_data",                   :default => false, :null => false
    t.string   "data_access_group"
  end

  add_index "study", ["accession_number"], :name => "study_accession_number_index"
  add_index "study", ["id_study_lims"], :name => "study_id_study_lims_index", :unique => true
  add_index "study", ["name"], :name => "study_name_index"
  add_index "study", ["uuid_study_lims"], :name => "study_uuid_study_lims_index"

  create_table "study_users", :primary_key => "id_study_users_tmp", :force => true do |t|
    t.integer  "id_study_tmp", :null => false
    t.datetime "last_updated", :null => false
    t.string   "role"
    t.string   "login"
    t.string   "email"
    t.string   "name"
  end

  add_index "study_users", ["id_study_tmp"], :name => "study_users_study_fk"

end
