-- MySQL dump 10.13  Distrib 5.6.20, for osx10.9 (x86_64)
--
-- Host: localhost    Database: unified_warehouse_development
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `flgen_plate`
--

DROP TABLE IF EXISTS `flgen_plate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flgen_plate` (
  `id_flgen_plate_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `cost_code` varchar(20) NOT NULL COMMENT 'Valid WTSI cost code',
  `id_lims` varchar(10) NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `plate_barcode` int(10) unsigned NOT NULL COMMENT 'Manufacturer (Fluidigm) chip barcode',
  `plate_barcode_lims` int(10) unsigned NOT NULL COMMENT 'LIMs-specific plate barcode',
  `plate_uuid_lims` varchar(36) DEFAULT NULL COMMENT 'LIMs-specific plate uuid',
  `id_flgen_plate_lims` varchar(20) NOT NULL COMMENT 'LIMs-specific plate id',
  `plate_size` smallint(6) DEFAULT NULL COMMENT 'Total number of wells on a plate',
  `plate_size_occupied` smallint(6) DEFAULT NULL COMMENT 'Number of occupied wells on a plate',
  `well_label` varchar(10) NOT NULL COMMENT 'Manufactuer well identifier within a plate, S001-S192',
  `well_uuid_lims` varchar(36) DEFAULT NULL COMMENT 'LIMs-specific well uuid',
  `qc_state` tinyint(1) DEFAULT NULL COMMENT 'QC state; 1 (pass), 0 (fail), NULL (not known)',
  PRIMARY KEY (`id_flgen_plate_tmp`),
  KEY `flgen_plate_id_lims_id_flgen_plate_lims_index` (`id_lims`,`id_flgen_plate_lims`),
  KEY `flgen_plate_sample_fk` (`id_sample_tmp`),
  KEY `flgen_plate_study_fk` (`id_study_tmp`),
  CONSTRAINT `flgen_plate_sample_fk` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `flgen_plate_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iseq_flowcell`
--

DROP TABLE IF EXISTS `iseq_flowcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iseq_flowcell` (
  `id_iseq_flowcell_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned DEFAULT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `cost_code` varchar(20) DEFAULT NULL COMMENT 'Valid WTSI cost code',
  `is_r_and_d` tinyint(1) DEFAULT '0' COMMENT 'A boolean flag derived from cost code, flags RandD',
  `id_lims` varchar(10) NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `priority` smallint(2) unsigned DEFAULT '1' COMMENT 'Priority',
  `manual_qc` tinyint(1) DEFAULT NULL COMMENT 'Manual QC decision, NULL for unknown',
  `external_release` tinyint(1) DEFAULT NULL COMMENT 'Defaults to manual qc value; can be changed by the user later',
  `flowcell_barcode` varchar(15) DEFAULT NULL COMMENT 'Manufacturer flowcell barcode or other identifier',
  `id_flowcell_lims` varchar(20) NOT NULL COMMENT 'LIMs-specific flowcell id, batch_id for Sequencescape',
  `position` smallint(2) unsigned NOT NULL COMMENT 'Flowcell lane number',
  `entity_type` varchar(30) NOT NULL COMMENT 'Lane type: library, pool, library_control, library_indexed, library_indexed_spike',
  `entity_id_lims` varchar(20) NOT NULL COMMENT 'Most specific LIMs identifier associated with this lane or plex or spike',
  `num_target_components` smallint(4) unsigned NOT NULL COMMENT 'Expected number of targets, one for a non-pool and number of target tags for a pool',
  `tag_index` smallint(5) unsigned DEFAULT NULL COMMENT 'Tag index, NULL if lane is not a pool',
  `tag_sequence` varchar(30) DEFAULT NULL COMMENT 'Tag sequence',
  `tag_set_id_lims` varchar(20) DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set',
  `tag_set_name` varchar(50) DEFAULT NULL COMMENT 'WTSI-wide tag set name',
  `is_spiked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating presence of a spike',
  `pipeline_id_lims` varchar(30) DEFAULT NULL COMMENT 'LIMs-specific pipeline identifier that unambiguously defines library type',
  `bait_name` varchar(50) DEFAULT NULL COMMENT 'WTSI-wide name that uniquely identifies a bait set',
  `requested_insert_size_from` int(5) unsigned DEFAULT NULL COMMENT 'Requested insert size min value',
  `requested_insert_size_to` int(5) unsigned DEFAULT NULL COMMENT 'Requested insert size max value',
  `forward_read_length` smallint(4) unsigned DEFAULT NULL COMMENT 'Requested forward read length, bp',
  `reverse_read_length` smallint(4) unsigned DEFAULT NULL COMMENT 'Requested reverse read length, bp',
  `id_pool_lims` varchar(20) NOT NULL COMMENT 'Most specific LIMs identifier associated with the pool',
  PRIMARY KEY (`id_iseq_flowcell_tmp`),
  KEY `iseq_flowcell_id_lims_id_flowcell_lims_index` (`id_lims`,`id_flowcell_lims`),
  KEY `iseq_flowcell_sample_fk` (`id_sample_tmp`),
  KEY `iseq_flowcell_study_fk` (`id_study_tmp`),
  CONSTRAINT `iseq_flowcell_sample_fk` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `iseq_flowcell_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iseq_product_metrics`
--

DROP TABLE IF EXISTS `iseq_product_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iseq_product_metrics` (
  `id_iseq_pr_metrics_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_iseq_flowcell_tmp` int(10) unsigned DEFAULT NULL COMMENT 'Flowcell id, see "iseq_flowcell.id_iseq_flowcell_tmp"',
  `id_run` int(10) unsigned NOT NULL COMMENT 'NPG run identifier',
  `position` smallint(2) unsigned NOT NULL COMMENT 'Flowcell lane number',
  `tag_index` smallint(5) unsigned DEFAULT NULL COMMENT 'Tag index, NULL if lane is not a pool',
  `tag_sequence4deplexing` varchar(30) DEFAULT NULL COMMENT 'Tag sequence used for deplexing the lane, common suffix might have been truncated',
  `actual_forward_read_length` smallint(4) unsigned DEFAULT NULL COMMENT 'Actual forward read length, bp',
  `actual_reverse_read_length` smallint(4) unsigned DEFAULT NULL COMMENT 'Actual reverse read length, bp',
  `indexing_read_length` smallint(2) unsigned DEFAULT NULL COMMENT 'Indexing read length, bp',
  `tag_decode_percent` float(5,2) unsigned DEFAULT NULL,
  `tag_decode_count` int(10) unsigned DEFAULT NULL,
  `insert_size_quartile1` smallint(5) unsigned DEFAULT NULL,
  `insert_size_quartile3` smallint(5) unsigned DEFAULT NULL,
  `insert_size_median` smallint(5) unsigned DEFAULT NULL,
  `gc_percent_forward_read` float(5,2) unsigned DEFAULT NULL,
  `gc_percent_reverse_read` float(5,2) unsigned DEFAULT NULL,
  `sequence_mismatch_percent_forward_read` float(4,2) unsigned DEFAULT NULL,
  `sequence_mismatch_percent_reverse_read` float(4,2) unsigned DEFAULT NULL,
  `adapters_percent_forward_read` float(5,2) unsigned DEFAULT NULL,
  `adapters_percent_reverse_read` float(5,2) unsigned DEFAULT NULL,
  `ref_match1_name` varchar(100) DEFAULT NULL,
  `ref_match1_percent` float(5,2) DEFAULT NULL,
  `ref_match2_name` varchar(100) DEFAULT NULL,
  `ref_match2_percent` float(5,2) DEFAULT NULL,
  `q20_yield_kb_forward_read` int(10) unsigned DEFAULT NULL,
  `q20_yield_kb_reverse_read` int(10) unsigned DEFAULT NULL,
  `q30_yield_kb_forward_read` int(10) unsigned DEFAULT NULL,
  `q30_yield_kb_reverse_read` int(10) unsigned DEFAULT NULL,
  `q40_yield_kb_forward_read` int(10) unsigned DEFAULT NULL,
  `q40_yield_kb_reverse_read` int(10) unsigned DEFAULT NULL,
  `num_reads` bigint(20) unsigned DEFAULT NULL,
  `percent_mapped` float(5,2) DEFAULT NULL,
  `percent_duplicate` float(5,2) DEFAULT NULL,
  `human_percent_mapped` float(5,2) DEFAULT NULL,
  `human_percent_duplicate` float(5,2) DEFAULT NULL,
  `genotype_sample_name_match` varchar(8) DEFAULT NULL,
  `genotype_sample_name_relaxed_match` varchar(8) DEFAULT NULL,
  `genotype_mean_depth` float(7,2) DEFAULT NULL,
  `mean_bait_coverage` float(6,2) unsigned DEFAULT NULL,
  `on_bait_percent` float(5,2) unsigned DEFAULT NULL,
  `on_or_near_bait_percent` float(5,2) unsigned DEFAULT NULL,
  `verify_bam_id_average_depth` smallint(5) unsigned DEFAULT NULL,
  `verify_bam_id_score` float(7,6) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_iseq_pr_metrics_tmp`),
  KEY `iseq_pm_run_index` (`id_run`),
  KEY `iseq_pm_run_pos_index` (`id_run`,`position`),
  KEY `iseq_pm_fcid_run_pos_tag_index` (`id_run`,`position`,`tag_index`),
  KEY `iseq_pr_metrics_flc_fk` (`id_iseq_flowcell_tmp`),
  KEY `iseq_pr_metrics_lm_fk` (`id_run`,`position`),
  CONSTRAINT `iseq_pr_metrics_flc_fk` FOREIGN KEY (`id_iseq_flowcell_tmp`) REFERENCES `iseq_flowcell` (`id_iseq_flowcell_tmp`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `iseq_pr_metrics_lm_fk` FOREIGN KEY (`id_run`, `position`) REFERENCES `iseq_run_lane_metrics` (`id_run`, `position`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iseq_run_lane_metrics`
--

DROP TABLE IF EXISTS `iseq_run_lane_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iseq_run_lane_metrics` (
  `id_iseq_flowcell_tmp` int(10) unsigned DEFAULT NULL COMMENT 'Flowcell id, see "iseq_flowcell.id_iseq_flowcell_tmp"',
  `flowcell_barcode` varchar(15) DEFAULT NULL COMMENT 'Manufacturer flowcell barcode or other identifier as recorded by NPG',
  `id_run` int(10) unsigned NOT NULL COMMENT 'NPG run identifier',
  `position` smallint(2) unsigned NOT NULL COMMENT 'Flowcell lane number',
  `instrument_name` char(32) DEFAULT NULL,
  `instrument_model` char(64) DEFAULT NULL,
  `paired_read` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `indexing_read_length` smallint(2) unsigned DEFAULT NULL COMMENT 'Actual reverse read length, bp',
  `cycles` int(4) unsigned NOT NULL,
  `cancelled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolen flag to indicate whether the run was cancelled',
  `run_pending` datetime DEFAULT NULL COMMENT 'Timestamp of run pending status',
  `run_complete` datetime DEFAULT NULL COMMENT 'Timestamp of run complete status',
  `qc_complete` datetime DEFAULT NULL COMMENT 'Timestamp of qc complete status',
  `pf_cluster_count` bigint(20) unsigned DEFAULT NULL,
  `raw_cluster_count` bigint(20) unsigned DEFAULT NULL,
  `raw_cluster_density` double(12,3) unsigned DEFAULT NULL,
  `pf_cluster_density` double(12,3) unsigned DEFAULT NULL,
  `pf_bases` bigint(20) unsigned DEFAULT NULL,
  `q20_yield_kb_forward_read` int(10) unsigned DEFAULT NULL,
  `q20_yield_kb_reverse_read` int(10) unsigned DEFAULT NULL,
  `q30_yield_kb_forward_read` int(10) unsigned DEFAULT NULL,
  `q30_yield_kb_reverse_read` int(10) unsigned DEFAULT NULL,
  `q40_yield_kb_forward_read` int(10) unsigned DEFAULT NULL,
  `q40_yield_kb_reverse_read` int(10) unsigned DEFAULT NULL,
  `tags_decode_percent` float(5,2) unsigned DEFAULT NULL,
  `tags_decode_cv` float(6,2) unsigned DEFAULT NULL,
  `adapters_percent_forward_read` float(5,2) unsigned DEFAULT NULL,
  `adapters_percent_reverse_read` float(5,2) unsigned DEFAULT NULL,
  `insert_size_quartile1` smallint(5) unsigned DEFAULT NULL,
  `insert_size_quartile3` smallint(5) unsigned DEFAULT NULL,
  `insert_size_median` smallint(5) unsigned DEFAULT NULL,
  `ref_match1_name` varchar(100) DEFAULT NULL,
  `ref_match1_percent` float(5,2) DEFAULT NULL,
  `ref_match2_name` varchar(100) DEFAULT NULL,
  `ref_match2_percent` float(5,2) DEFAULT NULL,
  `gc_percent_forward_read` float(5,2) unsigned DEFAULT NULL,
  `gc_percent_reverse_read` float(5,2) unsigned DEFAULT NULL,
  `sequence_mismatch_percent_forward_read` float(4,2) unsigned DEFAULT NULL,
  `sequence_mismatch_percent_reverse_read` float(4,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_run`,`position`),
  KEY `iseq_rlmm_id_run_index` (`id_run`),
  KEY `iseq_rlm_cancelled_and_run_pending_index` (`cancelled`,`run_pending`),
  KEY `iseq_rlm_cancelled_and_run_complete_index` (`cancelled`,`run_complete`),
  KEY `iseq_rl_metrics_flc_fk` (`id_iseq_flowcell_tmp`),
  CONSTRAINT `iseq_rl_metrics_flc_fk` FOREIGN KEY (`id_iseq_flowcell_tmp`) REFERENCES `iseq_flowcell` (`id_iseq_flowcell_tmp`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iseq_run_status`
--

DROP TABLE IF EXISTS `iseq_run_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iseq_run_status` (
  `id_run_status` int(11) unsigned NOT NULL,
  `id_run` int(10) unsigned NOT NULL COMMENT 'NPG run identifier',
  `date` datetime NOT NULL COMMENT 'Status timestamp',
  `id_run_status_dict` int(10) unsigned NOT NULL COMMENT 'Status identifier, see iseq_run_status_dict.id_run_status_dict',
  `iscurrent` tinyint(1) NOT NULL COMMENT 'Boolean flag, 1 is the status is current, 0 otherwise',
  PRIMARY KEY (`id_run_status`),
  KEY `iseq_run_status_rsd_fk` (`id_run_status_dict`),
  CONSTRAINT `iseq_run_status_rsd_fk` FOREIGN KEY (`id_run_status_dict`) REFERENCES `iseq_run_status_dict` (`id_run_status_dict`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iseq_run_status_dict`
--

DROP TABLE IF EXISTS `iseq_run_status_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iseq_run_status_dict` (
  `id_run_status_dict` int(10) unsigned NOT NULL,
  `description` varchar(64) NOT NULL,
  `iscurrent` tinyint(3) unsigned NOT NULL,
  `temporal_index` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_run_status_dict`),
  KEY `iseq_run_status_dict_description_index` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample` (
  `id_sample_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_lims` varchar(10) NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `uuid_sample_lims` varchar(36) DEFAULT NULL COMMENT 'LIMS-specific sample uuid',
  `id_sample_lims` varchar(20) NOT NULL COMMENT 'LIMS-specific sample identifier',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of sample deletion',
  `created` datetime DEFAULT NULL COMMENT 'Timestamp of sample creation',
  `name` varchar(255) DEFAULT NULL,
  `reference_genome` varchar(255) DEFAULT NULL,
  `organism` varchar(255) DEFAULT NULL,
  `accession_number` varchar(50) DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `description` text,
  `taxon_id` int(6) unsigned DEFAULT NULL,
  `father` varchar(255) DEFAULT NULL,
  `mother` varchar(255) DEFAULT NULL,
  `replicate` varchar(255) DEFAULT NULL,
  `ethnicity` varchar(255) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `cohort` varchar(255) DEFAULT NULL,
  `country_of_origin` varchar(255) DEFAULT NULL,
  `geographical_region` varchar(255) DEFAULT NULL,
  `sanger_sample_id` varchar(255) DEFAULT NULL,
  `control` tinyint(1) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `public_name` varchar(255) DEFAULT NULL,
  `sample_visibility` varchar(255) DEFAULT NULL,
  `strain` varchar(255) DEFAULT NULL,
  `consent_withdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `donor_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_sample_tmp`),
  UNIQUE KEY `sample_id_lims_id_sample_lims_index` (`id_lims`,`id_sample_lims`),
  UNIQUE KEY `sample_uuid_sample_lims_index` (`uuid_sample_lims`),
  KEY `sample_accession_number_index` (`accession_number`),
  KEY `sample_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study`
--

DROP TABLE IF EXISTS `study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `study` (
  `id_study_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_lims` varchar(10) NOT NULL COMMENT 'LIM system identifier, e.g. GCLP-CLARITY, SEQSCAPE',
  `uuid_study_lims` varchar(36) DEFAULT NULL COMMENT 'LIMS-specific study uuid',
  `id_study_lims` varchar(20) NOT NULL COMMENT 'LIMS-specific study identifier',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of study deletion',
  `created` datetime DEFAULT NULL COMMENT 'Timestamp of study creation',
  `name` varchar(255) DEFAULT NULL,
  `reference_genome` varchar(255) DEFAULT NULL,
  `ethically_approved` tinyint(1) DEFAULT NULL,
  `faculty_sponsor` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `study_type` varchar(50) DEFAULT NULL,
  `abstract` text,
  `abbreviation` varchar(255) DEFAULT NULL,
  `accession_number` varchar(50) DEFAULT NULL,
  `description` text,
  `contains_human_dna` varchar(255) DEFAULT NULL,
  `contaminated_human_dna` varchar(255) DEFAULT NULL,
  `data_release_strategy` varchar(255) DEFAULT NULL,
  `data_release_sort_of_study` varchar(255) DEFAULT NULL,
  `ena_project_id` varchar(255) DEFAULT NULL,
  `study_title` varchar(255) DEFAULT NULL,
  `study_visibility` varchar(255) DEFAULT NULL,
  `ega_dac_accession_number` varchar(255) DEFAULT NULL,
  `array_express_accession_number` varchar(255) DEFAULT NULL,
  `ega_policy_accession_number` varchar(255) DEFAULT NULL,
  `data_release_timing` varchar(255) DEFAULT NULL,
  `data_release_delay_period` varchar(255) DEFAULT NULL,
  `data_release_delay_reason` varchar(255) DEFAULT NULL,
  `remove_x_and_autosomes` tinyint(1) NOT NULL DEFAULT '0',
  `aligned` tinyint(1) NOT NULL DEFAULT '1',
  `separate_y_chromosome_data` tinyint(1) NOT NULL DEFAULT '0',
  `data_access_group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_study_tmp`),
  UNIQUE KEY `study_id_lims_id_study_lims_index` (`id_lims`,`id_study_lims`),
  UNIQUE KEY `study_uuid_study_lims_index` (`uuid_study_lims`),
  KEY `study_accession_number_index` (`accession_number`),
  KEY `study_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study_users`
--

DROP TABLE IF EXISTS `study_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `study_users` (
  `id_study_users_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `role` varchar(255) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_study_users_tmp`),
  KEY `study_users_study_fk` (`id_study_tmp`),
  CONSTRAINT `study_users_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-13 13:32:10
INSERT INTO schema_migrations (version) VALUES ('20141113110635');

INSERT INTO schema_migrations (version) VALUES ('20141113130813');

