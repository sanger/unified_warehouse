
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `bmap_flowcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bmap_flowcell` (
  `id_bmap_flowcell_tmp` int NOT NULL AUTO_INCREMENT,
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `experiment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the experiment, eg. The lims generated run id',
  `instrument_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the instrument on which the sample was run',
  `enzyme_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the recognition enzyme used',
  `chip_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Manufacturer chip identifier',
  `chip_serialnumber` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Manufacturer chip identifier',
  `position` int unsigned DEFAULT NULL COMMENT 'Flowcell position',
  `id_flowcell_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific flowcell id',
  `id_library_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Earliest LIMs identifier associated with library creation',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  PRIMARY KEY (`id_bmap_flowcell_tmp`),
  KEY `index_bmap_flowcell_on_id_flowcell_lims` (`id_flowcell_lims`),
  KEY `index_bmap_flowcell_on_id_library_lims` (`id_library_lims`),
  KEY `fk_bmap_flowcell_to_sample` (`id_sample_tmp`),
  KEY `fk_bmap_flowcell_to_study` (`id_study_tmp`),
  CONSTRAINT `fk_bmap_flowcell_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bmap_flowcell_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `flgen_plate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flgen_plate` (
  `id_flgen_plate_tmp` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `cost_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Valid WTSI cost code',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `plate_barcode` int unsigned NOT NULL COMMENT 'Manufacturer (Fluidigm) chip barcode',
  `plate_barcode_lims` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific plate barcode',
  `plate_uuid_lims` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific plate uuid',
  `id_flgen_plate_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific plate id',
  `plate_size` smallint DEFAULT NULL COMMENT 'Total number of wells on a plate',
  `plate_size_occupied` smallint DEFAULT NULL COMMENT 'Number of occupied wells on a plate',
  `well_label` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Manufactuer well identifier within a plate, S001-S192',
  `well_uuid_lims` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific well uuid',
  `qc_state` tinyint(1) DEFAULT NULL COMMENT 'QC state; 1 (pass), 0 (fail), NULL (not known)',
  PRIMARY KEY (`id_flgen_plate_tmp`),
  KEY `flgen_plate_id_lims_id_flgen_plate_lims_index` (`id_lims`,`id_flgen_plate_lims`),
  KEY `flgen_plate_sample_fk` (`id_sample_tmp`),
  KEY `flgen_plate_study_fk` (`id_study_tmp`),
  CONSTRAINT `flgen_plate_sample_fk` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`),
  CONSTRAINT `flgen_plate_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `iseq_flowcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iseq_flowcell` (
  `id_iseq_flowcell_tmp` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int unsigned DEFAULT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `cost_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Valid WTSI cost code',
  `is_r_and_d` tinyint(1) DEFAULT '0' COMMENT 'A boolean flag derived from cost code, flags RandD',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `priority` smallint unsigned DEFAULT '1' COMMENT 'Priority',
  `manual_qc` tinyint(1) DEFAULT NULL COMMENT 'Manual QC decision, NULL for unknown',
  `external_release` tinyint(1) DEFAULT NULL COMMENT 'Defaults to manual qc value; can be changed by the user later',
  `flowcell_barcode` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Manufacturer flowcell barcode or other identifier',
  `reagent_kit_barcode` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The barcode for the reagent kit or cartridge',
  `id_flowcell_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific flowcell id, batch_id for Sequencescape',
  `position` smallint unsigned NOT NULL COMMENT 'Flowcell lane number',
  `entity_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lane type: library, pool, library_control, library_indexed, library_indexed_spike',
  `entity_id_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Most specific LIMs identifier associated with this lane or plex or spike',
  `tag_index` smallint unsigned DEFAULT NULL COMMENT 'Tag index, NULL if lane is not a pool',
  `tag_sequence` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence',
  `tag_set_id_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set',
  `tag_set_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name',
  `tag_identifier` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The position of tag within the tag group',
  `tag2_sequence` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence for tag 2',
  `tag2_set_id_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for tag 2',
  `tag2_set_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for tag 2',
  `tag2_identifier` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The position of tag2 within the tag group',
  `is_spiked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating presence of a spike',
  `pipeline_id_lims` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific pipeline identifier that unambiguously defines library type',
  `bait_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide name that uniquely identifies a bait set',
  `requested_insert_size_from` int unsigned DEFAULT NULL COMMENT 'Requested insert size min value',
  `requested_insert_size_to` int unsigned DEFAULT NULL COMMENT 'Requested insert size max value',
  `forward_read_length` smallint unsigned DEFAULT NULL COMMENT 'Requested forward read length, bp',
  `reverse_read_length` smallint unsigned DEFAULT NULL COMMENT 'Requested reverse read length, bp',
  `id_pool_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Most specific LIMs identifier associated with the pool',
  `legacy_library_id` int DEFAULT NULL COMMENT 'Legacy library_id for backwards compatibility.',
  `id_library_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Earliest LIMs identifier associated with library creation',
  `team` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The team responsible for creating the flowcell',
  `purpose` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Describes the reason the sequencing was conducted. Eg. Standard, QC, Control',
  `suboptimal` tinyint(1) DEFAULT NULL COMMENT 'Indicates that a sample has failed a QC step during processing',
  `primer_panel` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Primer Panel name',
  `spiked_phix_barcode` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Barcode of the PhiX tube added to the lane',
  `spiked_phix_percentage` float DEFAULT NULL COMMENT 'Percentage PhiX tube spiked in the pool in terms of molar concentration',
  `loading_concentration` float DEFAULT NULL COMMENT 'Final instrument loading concentration (pM)',
  `workflow` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Workflow used when processing the flowcell',
  PRIMARY KEY (`id_iseq_flowcell_tmp`),
  UNIQUE KEY `index_iseq_flowcell_id_flowcell_lims_position_tag_index_id_lims` (`id_flowcell_lims`,`position`,`tag_index`,`id_lims`),
  KEY `iseq_flowcell_id_lims_id_flowcell_lims_index` (`id_lims`,`id_flowcell_lims`),
  KEY `iseq_flowcell_sample_fk` (`id_sample_tmp`),
  KEY `iseq_flowcell_study_fk` (`id_study_tmp`),
  KEY `index_iseq_flowcell_on_id_pool_lims` (`id_pool_lims`),
  KEY `index_iseq_flowcell_on_id_library_lims` (`id_library_lims`),
  KEY `index_iseqflowcell__id_flowcell_lims__position__tag_index` (`id_flowcell_lims`,`position`,`tag_index`),
  KEY `index_iseqflowcell__flowcell_barcode__position__tag_index` (`flowcell_barcode`,`position`,`tag_index`),
  KEY `index_iseq_flowcell_legacy_library_id` (`legacy_library_id`),
  CONSTRAINT `iseq_flowcell_sample_fk` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`),
  CONSTRAINT `iseq_flowcell_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `lighthouse_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lighthouse_sample` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mongodb_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Auto-generated id from MongoDB',
  `root_sample_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Id for this sample provided by the Lighthouse lab',
  `cog_uk_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Consortium-wide id, generated by Sanger on import to LIMS',
  `rna_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lighthouse lab-provided id made up of plate barcode and well',
  `plate_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Barcode of plate sample arrived in, from rna_id',
  `coordinate` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Well position from plate sample arrived in, from rna_id',
  `result` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Covid-19 test result from the Lighthouse lab',
  `date_tested_string` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'When the covid-19 test was carried out by the Lighthouse lab',
  `date_tested` datetime DEFAULT NULL COMMENT 'date_tested_string in date format',
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Lighthouse centre that the sample came from',
  `lab_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Id of the lab, within the Lighthouse centre',
  `ch1_target` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Target for channel 1',
  `ch1_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Result for channel 1',
  `ch1_cq` decimal(11,8) DEFAULT NULL COMMENT 'Cq value for channel 1',
  `ch2_target` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Target for channel 2',
  `ch2_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Result for channel 2',
  `ch2_cq` decimal(11,8) DEFAULT NULL COMMENT 'Cq value for channel 2',
  `ch3_target` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Target for channel 3',
  `ch3_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Result for channel 3',
  `ch3_cq` decimal(11,8) DEFAULT NULL COMMENT 'Cq value for channel 3',
  `ch4_target` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Target for channel 4',
  `ch4_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Result for channel 4',
  `ch4_cq` decimal(11,8) DEFAULT NULL COMMENT 'Cq value for channel 4',
  `filtered_positive` tinyint(1) DEFAULT NULL COMMENT 'Filtered positive result value',
  `filtered_positive_version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Filtered positive version',
  `filtered_positive_timestamp` datetime DEFAULT NULL COMMENT 'Filtered positive timestamp',
  `created_at` datetime DEFAULT NULL COMMENT 'When this record was inserted',
  `updated_at` datetime DEFAULT NULL COMMENT 'When this record was last updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_lighthouse_sample_on_root_sample_id_and_rna_id_and_result` (`root_sample_id`,`rna_id`,`result`),
  UNIQUE KEY `index_lighthouse_sample_on_mongodb_id` (`mongodb_id`),
  KEY `index_lighthouse_sample_on_date_tested` (`date_tested`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `oseq_flowcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oseq_flowcell` (
  `id_oseq_flowcell_tmp` int unsigned NOT NULL AUTO_INCREMENT,
  `id_flowcell_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific flowcell id',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `experiment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the experiment, eg. The lims generated run id',
  `instrument_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the instrument on which the sample was run',
  `instrument_slot` int NOT NULL COMMENT 'The numeric identifier of the slot on which the sample was run',
  `pipeline_id_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific pipeline identifier that unambiguously defines library type',
  `requested_data_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The type of data produced by sequencing, eg. basecalls only',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of any flowcell destruction',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  `tag_identifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Position of the first tag within the tag group',
  `tag_sequence` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Sequence of the first tag',
  `tag_set_id_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for the first tag',
  `tag_set_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for the first tag',
  `tag2_identifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Position of the second tag within the tag group',
  `tag2_sequence` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Sequence of the second tag',
  `tag2_set_id_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for the second tag',
  `tag2_set_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for the second tag',
  PRIMARY KEY (`id_oseq_flowcell_tmp`),
  KEY `fk_oseq_flowcell_to_sample` (`id_sample_tmp`),
  KEY `fk_oseq_flowcell_to_study` (`id_study_tmp`),
  CONSTRAINT `fk_oseq_flowcell_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_oseq_flowcell_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `pac_bio_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pac_bio_run` (
  `id_pac_bio_tmp` int NOT NULL AUTO_INCREMENT,
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "study.id_study_tmp"',
  `id_pac_bio_run_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lims specific identifier for the pacbio run',
  `pac_bio_run_uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Uuid identifier for the pacbio run',
  `cost_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Valid WTSI cost-code',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  `tag_identifier` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag index within tag set, NULL if untagged',
  `tag_sequence` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence for tag',
  `tag_set_id_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for tag',
  `tag_set_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for tag',
  `tag2_sequence` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence for tag 2',
  `tag2_set_id_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for tag 2',
  `tag2_set_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for tag 2',
  `tag2_identifier` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The position of tag2 within the tag group',
  `plate_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The human readable barcode for the plate loaded onto the machine',
  `plate_uuid_lims` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The plate uuid',
  `well_label` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The well identifier for the plate, A1-H12',
  `well_uuid_lims` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The well uuid',
  `pac_bio_library_tube_id_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS specific identifier for originating library tube',
  `pac_bio_library_tube_uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The uuid for the originating library tube',
  `pac_bio_library_tube_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the originating library tube',
  `pac_bio_library_tube_legacy_id` int DEFAULT NULL COMMENT 'Legacy library_id for backwards compatibility.',
  `library_created_at` datetime DEFAULT NULL COMMENT 'Timestamp of library creation',
  `pac_bio_run_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name of the run',
  PRIMARY KEY (`id_pac_bio_tmp`),
  KEY `fk_pac_bio_run_to_sample` (`id_sample_tmp`),
  KEY `fk_pac_bio_run_to_study` (`id_study_tmp`),
  CONSTRAINT `fk_pac_bio_run_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_pac_bio_run_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `qc_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qc_result` (
  `id_qc_result_tmp` int NOT NULL AUTO_INCREMENT,
  `id_sample_tmp` int unsigned NOT NULL,
  `id_qc_result_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS-specific qc_result identifier',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS system identifier (e.g. SEQUENCESCAPE)',
  `id_pool_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Most specific LIMs identifier associated with the pool. (Asset external_identifier in SS)',
  `id_library_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Earliest LIMs identifier associated with library creation. (Aliquot external_identifier in SS)',
  `labware_purpose` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Labware Purpose name. (e.g. Plate Purpose for a Well)',
  `assay` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'assay type and version',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Value of the mesurement',
  `units` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Mesurement unit',
  `cv` float DEFAULT NULL COMMENT 'Coefficient of variance',
  `qc_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Type of mesurement',
  `date_created` datetime NOT NULL COMMENT 'The date the qc_result was first created in SS',
  `last_updated` datetime NOT NULL COMMENT 'The date the qc_result was last updated in SS',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  PRIMARY KEY (`id_qc_result_tmp`),
  KEY `fk_qc_result_to_sample` (`id_sample_tmp`),
  KEY `lookup_index` (`id_qc_result_lims`,`id_lims`),
  KEY `qc_result_id_library_lims_index` (`id_library_lims`),
  CONSTRAINT `fk_qc_result_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample` (
  `id_sample_tmp` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `uuid_sample_lims` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMS-specific sample uuid',
  `id_sample_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS-specific sample identifier',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of sample deletion',
  `created` datetime DEFAULT NULL COMMENT 'Timestamp of sample creation',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference_genome` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `organism` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `accession_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `common_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `taxon_id` int unsigned DEFAULT NULL,
  `father` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `mother` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `replicate` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ethnicity` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `cohort` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_of_origin` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `geographical_region` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sanger_sample_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `control` tinyint(1) DEFAULT NULL,
  `supplier_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `public_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sample_visibility` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `strain` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `consent_withdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `donor_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phenotype` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The phenotype of the sample as described in Sequencescape',
  `developmental_stage` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Developmental Stage',
  `control_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_sample_tmp`),
  UNIQUE KEY `index_sample_on_id_sample_lims_and_id_lims` (`id_sample_lims`,`id_lims`),
  UNIQUE KEY `sample_uuid_sample_lims_index` (`uuid_sample_lims`),
  KEY `sample_accession_number_index` (`accession_number`),
  KEY `sample_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=49650 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `samples_extraction_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `samples_extraction_activity` (
  `id_activity_tmp` int NOT NULL AUTO_INCREMENT,
  `id_activity_lims` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific activity id',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `activity_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The type of the activity performed',
  `instrument` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the instrument used to perform the activity',
  `kit_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the kit used to perform the activity',
  `kit_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The type of kit used to perform the activity',
  `input_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the labware (eg. plate or tube) at the begining of the activity',
  `output_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the labware (eg. plate or tube)  at the end of the activity',
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the user who was most recently associated with the activity',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last change to activity',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `completed_at` datetime NOT NULL COMMENT 'Timestamp of activity completion',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of any activity removal',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  PRIMARY KEY (`id_activity_tmp`),
  KEY `index_samples_extraction_activity_on_id_activity_lims` (`id_activity_lims`),
  KEY `fk_rails_bbdd0468f0` (`id_sample_tmp`),
  CONSTRAINT `fk_rails_bbdd0468f0` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`)
) ENGINE=InnoDB AUTO_INCREMENT=35657 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `stock_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_resource` (
  `id_stock_resource_tmp` int NOT NULL AUTO_INCREMENT,
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `created` datetime NOT NULL COMMENT 'Timestamp of initial registration of stock in LIMS',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of initial registration of deletion in parent LIMS. NULL if not deleted.',
  `id_sample_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int unsigned NOT NULL COMMENT 'Sample id, see "study.id_study_tmp"',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  `id_stock_resource_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lims specific identifier for the stock',
  `stock_resource_uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Uuid identifier for the stock',
  `labware_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The type of labware containing the stock. eg. Well, Tube',
  `labware_machine_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the containing labware as read by a barcode scanner',
  `labware_human_barcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the containing labware in human readable format',
  `labware_coordinate` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'For wells, the coordinate on the containing plate. Null for tubes.',
  `current_volume` float DEFAULT NULL COMMENT 'The current volume of material in microlitres based on measurements and know usage',
  `initial_volume` float DEFAULT NULL COMMENT 'The result of the initial volume measurement in microlitres conducted on the material',
  `concentration` float DEFAULT NULL COMMENT 'The concentration of material recorded in the lab in nanograms per microlitre',
  `gel_pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The recorded result for the qel QC assay.',
  `pico_pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The recorded result for the pico green assay. A pass indicates a successful assay, not sufficient material.',
  `snp_count` int DEFAULT NULL COMMENT 'The number of markers detected in genotyping assays',
  `measured_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The gender call base on the genotyping assay',
  PRIMARY KEY (`id_stock_resource_tmp`),
  KEY `fk_stock_resource_to_sample` (`id_sample_tmp`),
  KEY `fk_stock_resource_to_study` (`id_study_tmp`),
  KEY `composition_lookup_index` (`id_stock_resource_lims`,`id_sample_tmp`,`id_lims`),
  CONSTRAINT `fk_stock_resource_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_stock_resource_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study` (
  `id_study_tmp` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_lims` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. GCLP-CLARITY, SEQSCAPE',
  `uuid_study_lims` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMS-specific study uuid',
  `id_study_lims` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS-specific study identifier',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of study deletion',
  `created` datetime DEFAULT NULL COMMENT 'Timestamp of study creation',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference_genome` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ethically_approved` tinyint(1) DEFAULT NULL,
  `faculty_sponsor` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `study_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `abstract` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `abbreviation` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `accession_number` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `contains_human_dna` tinyint(1) DEFAULT NULL COMMENT 'Lane may contain human DNA',
  `contaminated_human_dna` tinyint(1) DEFAULT NULL COMMENT 'Human DNA in the lane is a contaminant and should be removed',
  `data_release_strategy` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_sort_of_study` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ena_project_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `study_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `study_visibility` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ega_dac_accession_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `array_express_accession_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ega_policy_accession_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_timing` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_delay_period` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_delay_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `remove_x_and_autosomes` tinyint(1) NOT NULL DEFAULT '0',
  `aligned` tinyint(1) NOT NULL DEFAULT '1',
  `separate_y_chromosome_data` tinyint(1) NOT NULL DEFAULT '0',
  `data_access_group` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `prelim_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The preliminary study id prior to entry into the LIMS',
  `hmdmc_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The Human Materials and Data Management Committee approval number(s) for the study.',
  `data_destination` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The data destination type(s) for the study. It could be ''standard'', ''14mg'' or ''gseq''. This may be extended, if Sanger gains more external customers. It can contain multiply destinations separated by a space.',
  `s3_email_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_deletion_period` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_study_tmp`),
  UNIQUE KEY `study_id_lims_id_study_lims_index` (`id_lims`,`id_study_lims`),
  UNIQUE KEY `study_uuid_study_lims_index` (`uuid_study_lims`),
  KEY `study_accession_number_index` (`accession_number`),
  KEY `study_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `study_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_users` (
  `id_study_users_tmp` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_study_tmp` int unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_study_users_tmp`),
  KEY `study_users_study_fk` (`id_study_tmp`),
  CONSTRAINT `study_users_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20141113110635'),
('20141113130813'),
('20141120101916'),
('20141120123833'),
('20150113120636'),
('20150113134336'),
('20150113142419'),
('20150401132814'),
('20150401145741'),
('20150401150636'),
('20150601112933'),
('20150813094119'),
('20150813122539'),
('20150813125229'),
('20150819120400'),
('20150827140317'),
('20150917082634'),
('20150917100509'),
('20151110102754'),
('20151127094701'),
('20160120155501'),
('20160420084130'),
('20160422095926'),
('20160621125538'),
('20160810093024'),
('20160919144230'),
('20170412135215'),
('20170427123459'),
('20170601102958'),
('20170608082257'),
('20170717092510'),
('20170717093707'),
('20170816121503'),
('20171005105857'),
('20180222132523'),
('20180510132219'),
('20180511093531'),
('20180731122912'),
('20180731142628'),
('20180821113540'),
('20181016142505'),
('20181210145626'),
('20190118111752'),
('20190403081352'),
('20191015143307'),
('20200131111908'),
('20200512152113'),
('20200518083730'),
('20200903104439'),
('20200909085557'),
('20200929142921'),
('20201028091922'),
('20201029150039'),
('20201103161806');


