-- MySQL dump 10.13  Distrib 8.0.12, for osx10.12 (x86_64)
--
-- Host: localhost    Database: unified_warehouse_test
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `flgen_plate` (
  `id_flgen_plate_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `cost_code` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Valid WTSI cost code',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `plate_barcode` int(10) unsigned NOT NULL COMMENT 'Manufacturer (Fluidigm) chip barcode',
  `plate_barcode_lims` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific plate barcode',
  `plate_uuid_lims` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific plate uuid',
  `id_flgen_plate_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific plate id',
  `plate_size` smallint(6) DEFAULT NULL COMMENT 'Total number of wells on a plate',
  `plate_size_occupied` smallint(6) DEFAULT NULL COMMENT 'Number of occupied wells on a plate',
  `well_label` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Manufactuer well identifier within a plate, S001-S192',
  `well_uuid_lims` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific well uuid',
  `qc_state` tinyint(1) DEFAULT NULL COMMENT 'QC state; 1 (pass), 0 (fail), NULL (not known)',
  PRIMARY KEY (`id_flgen_plate_tmp`),
  KEY `flgen_plate_id_lims_id_flgen_plate_lims_index` (`id_lims`,`id_flgen_plate_lims`),
  KEY `flgen_plate_sample_fk` (`id_sample_tmp`),
  KEY `flgen_plate_study_fk` (`id_study_tmp`),
  CONSTRAINT `flgen_plate_sample_fk` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`),
  CONSTRAINT `flgen_plate_study_fk` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iseq_flowcell`
--

DROP TABLE IF EXISTS `iseq_flowcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `iseq_flowcell` (
  `id_iseq_flowcell_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned DEFAULT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `cost_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Valid WTSI cost code',
  `is_r_and_d` tinyint(1) DEFAULT '0' COMMENT 'A boolean flag derived from cost code, flags RandD',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `priority` smallint(2) unsigned DEFAULT '1' COMMENT 'Priority',
  `manual_qc` tinyint(1) DEFAULT NULL COMMENT 'Manual QC decision, NULL for unknown',
  `external_release` tinyint(1) DEFAULT NULL COMMENT 'Defaults to manual qc value; can be changed by the user later',
  `flowcell_barcode` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Manufacturer flowcell barcode or other identifier',
  `reagent_kit_barcode` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The barcode for the reagent kit or cartridge',
  `id_flowcell_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific flowcell id, batch_id for Sequencescape',
  `position` smallint(2) unsigned NOT NULL COMMENT 'Flowcell lane number',
  `entity_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lane type: library, pool, library_control, library_indexed, library_indexed_spike',
  `entity_id_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Most specific LIMs identifier associated with this lane or plex or spike',
  `tag_index` smallint(5) unsigned DEFAULT NULL COMMENT 'Tag index, NULL if lane is not a pool',
  `tag_sequence` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence',
  `tag_set_id_lims` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set',
  `tag_set_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name',
  `tag_identifier` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The position of tag within the tag group',
  `tag2_sequence` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence for tag 2',
  `tag2_set_id_lims` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for tag 2',
  `tag2_set_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for tag 2',
  `tag2_identifier` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The position of tag2 within the tag group',
  `is_spiked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating presence of a spike',
  `pipeline_id_lims` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific pipeline identifier that unambiguously defines library type',
  `bait_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide name that uniquely identifies a bait set',
  `requested_insert_size_from` int(5) unsigned DEFAULT NULL COMMENT 'Requested insert size min value',
  `requested_insert_size_to` int(5) unsigned DEFAULT NULL COMMENT 'Requested insert size max value',
  `forward_read_length` smallint(4) unsigned DEFAULT NULL COMMENT 'Requested forward read length, bp',
  `reverse_read_length` smallint(4) unsigned DEFAULT NULL COMMENT 'Requested reverse read length, bp',
  `id_pool_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Most specific LIMs identifier associated with the pool',
  `legacy_library_id` int(11) DEFAULT NULL COMMENT 'Legacy library_id for backwards compatibility.',
  `id_library_lims` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Earliest LIMs identifier associated with library creation',
  `team` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The team responsible for creating the flowcell',
  `purpose` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Describes the reason the sequencing was conducted. Eg. Standard, QC, Control',
  `suboptimal` tinyint(1) DEFAULT NULL COMMENT 'Indicates that a sample has failed a QC step during processing',
  `primer_panel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Primer Panel name',
  `spiked_phix_barcode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Barcode of the PhiX tube added to the lane',
  `spiked_phix_percentage` float DEFAULT NULL COMMENT 'Percentage PhiX tube spiked in the pool in terms of molar concentration',
  `loading_concentration` float DEFAULT NULL COMMENT 'Final instrument loading concentration (pM)',
  `workflow` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Workflow used when processing the flowcell',
  PRIMARY KEY (`id_iseq_flowcell_tmp`),
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

--
-- Table structure for table `oseq_flowcell`
--

DROP TABLE IF EXISTS `oseq_flowcell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `oseq_flowcell` (
  `id_oseq_flowcell_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_flowcell_lims` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific flowcell id',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `experiment_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the experiment, eg. The lims generated run id',
  `instrument_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the instrument on which the sample was run',
  `instrument_slot` int(11) NOT NULL COMMENT 'The numeric identifier of the slot on which the sample was run',
  `pipeline_id_lims` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMs-specific pipeline identifier that unambiguously defines library type',
  `requested_data_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The type of data produces by sequencing, eg. basecalls only',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of any flowcell destruction',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  PRIMARY KEY (`id_oseq_flowcell_tmp`),
  KEY `fk_oseq_flowcell_to_sample` (`id_sample_tmp`),
  KEY `fk_oseq_flowcell_to_study` (`id_study_tmp`),
  CONSTRAINT `fk_oseq_flowcell_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`),
  CONSTRAINT `fk_oseq_flowcell_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pac_bio_run`
--

DROP TABLE IF EXISTS `pac_bio_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pac_bio_run` (
  `id_pac_bio_tmp` int(11) NOT NULL AUTO_INCREMENT,
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "study.id_study_tmp"',
  `id_pac_bio_run_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lims specific identifier for the pacbio run',
  `pac_bio_run_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Uuid identifier for the pacbio run',
  `cost_code` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Valid WTSI cost-code',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  `tag_identifier` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag index within tag set, NULL if untagged',
  `tag_sequence` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Tag sequence for tag',
  `tag_set_id_lims` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMs-specific identifier of the tag set for tag',
  `tag_set_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'WTSI-wide tag set name for tag',
  `plate_barcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The human readable barcode for the plate loaded onto the machine',
  `plate_uuid_lims` varchar(36) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The plate uuid',
  `well_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The well identifier for the plate, A1-H12',
  `well_uuid_lims` varchar(36) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The well uuid',
  `pac_bio_library_tube_id_lims` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS specific identifier for originating library tube',
  `pac_bio_library_tube_uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The uuid for the originating library tube',
  `pac_bio_library_tube_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The name of the originating library tube',
  `pac_bio_library_tube_legacy_id` int(11) DEFAULT NULL COMMENT 'Legacy library_id for backwards compatibility.',
  `library_created_at` datetime DEFAULT NULL COMMENT 'Timestamp of library creation',
  PRIMARY KEY (`id_pac_bio_tmp`),
  KEY `fk_pac_bio_run_to_sample` (`id_sample_tmp`),
  KEY `fk_pac_bio_run_to_study` (`id_study_tmp`),
  CONSTRAINT `fk_pac_bio_run_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`),
  CONSTRAINT `fk_pac_bio_run_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qc_result`
--

DROP TABLE IF EXISTS `qc_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `qc_result` (
  `id_qc_result_tmp` int(11) NOT NULL AUTO_INCREMENT,
  `id_sample_tmp` int(10) unsigned NOT NULL,
  `id_qc_result_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS-specific qc_result identifier',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS system identifier (e.g. SEQUENCESCAPE)',
  `id_pool_lims` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Most specific LIMs identifier associated with the pool. (Asset external_identifier in SS)',
  `id_library_lims` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Earliest LIMs identifier associated with library creation. (Aliquot external_identifier in SS)',
  `labware_purpose` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Labware Purpose name. (e.g. Plate Purpose for a Well)',
  `assay` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'assay type and version',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Value of the mesurement',
  `units` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Mesurement unit',
  `cv` float DEFAULT NULL COMMENT 'Coefficient of variance',
  `qc_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Type of mesurement',
  `date_created` datetime NOT NULL COMMENT 'The date the qc_result was first created in SS',
  `last_updated` datetime NOT NULL COMMENT 'The date the qc_result was last updated in SS',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  PRIMARY KEY (`id_qc_result_tmp`),
  KEY `fk_qc_result_to_sample` (`id_sample_tmp`),
  KEY `lookup_index` (`id_qc_result_lims`,`id_lims`),
  CONSTRAINT `fk_qc_result_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sample` (
  `id_sample_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE',
  `uuid_sample_lims` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMS-specific sample uuid',
  `id_sample_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS-specific sample identifier',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of sample deletion',
  `created` datetime DEFAULT NULL COMMENT 'Timestamp of sample creation',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference_genome` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organism` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accession_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `common_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `taxon_id` int(6) unsigned DEFAULT NULL,
  `father` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mother` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `replicate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ethnicity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cohort` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_of_origin` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geographical_region` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sanger_sample_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `control` tinyint(1) DEFAULT NULL,
  `supplier_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `public_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sample_visibility` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `strain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `consent_withdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `donor_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phenotype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The phenotype of the sample as described in Sequencescape',
  `developmental_stage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Developmental Stage',
  PRIMARY KEY (`id_sample_tmp`),
  UNIQUE KEY `index_sample_on_id_sample_lims_and_id_lims` (`id_sample_lims`,`id_lims`),
  UNIQUE KEY `sample_uuid_sample_lims_index` (`uuid_sample_lims`),
  KEY `sample_accession_number_index` (`accession_number`),
  KEY `sample_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_resource`
--

DROP TABLE IF EXISTS `stock_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `stock_resource` (
  `id_stock_resource_tmp` int(11) NOT NULL AUTO_INCREMENT,
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `created` datetime NOT NULL COMMENT 'Timestamp of initial registration of stock in LIMS',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of initial registration of deletion in parent LIMS. NULL if not deleted.',
  `id_sample_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "sample.id_sample_tmp"',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Sample id, see "study.id_study_tmp"',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier',
  `id_stock_resource_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Lims specific identifier for the stock',
  `stock_resource_uuid` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Uuid identifier for the stock',
  `labware_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The type of labware containing the stock. eg. Well, Tube',
  `labware_machine_barcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the containing labware as read by a barcode scanner',
  `labware_human_barcode` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The barcode of the containing labware in human readable format',
  `labware_coordinate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'For wells, the coordinate on the containing plate. Null for tubes.',
  `current_volume` float DEFAULT NULL COMMENT 'The current volume of material in microlitres based on measurements and know usage',
  `initial_volume` float DEFAULT NULL COMMENT 'The result of the initial volume measurement in microlitres conducted on the material',
  `concentration` float DEFAULT NULL COMMENT 'The concentration of material recorded in the lab in nanograms per microlitre',
  `gel_pass` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The recorded result for the qel QC assay.',
  `pico_pass` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The recorded result for the pico green assay. A pass indicates a successful assay, not sufficient material.',
  `snp_count` int(11) DEFAULT NULL COMMENT 'The number of markers detected in genotyping assays',
  `measured_gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The gender call base on the genotyping assay',
  PRIMARY KEY (`id_stock_resource_tmp`),
  KEY `fk_stock_resource_to_sample` (`id_sample_tmp`),
  KEY `fk_stock_resource_to_study` (`id_study_tmp`),
  KEY `composition_lookup_index` (`id_stock_resource_lims`,`id_sample_tmp`,`id_lims`),
  CONSTRAINT `fk_stock_resource_to_sample` FOREIGN KEY (`id_sample_tmp`) REFERENCES `sample` (`id_sample_tmp`),
  CONSTRAINT `fk_stock_resource_to_study` FOREIGN KEY (`id_study_tmp`) REFERENCES `study` (`id_study_tmp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study`
--

DROP TABLE IF EXISTS `study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `study` (
  `id_study_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_lims` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIM system identifier, e.g. GCLP-CLARITY, SEQSCAPE',
  `uuid_study_lims` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'LIMS-specific study uuid',
  `id_study_lims` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'LIMS-specific study identifier',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `recorded_at` datetime NOT NULL COMMENT 'Timestamp of warehouse update',
  `deleted_at` datetime DEFAULT NULL COMMENT 'Timestamp of study deletion',
  `created` datetime DEFAULT NULL COMMENT 'Timestamp of study creation',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference_genome` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ethically_approved` tinyint(1) DEFAULT NULL,
  `faculty_sponsor` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `study_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abstract` text COLLATE utf8_unicode_ci,
  `abbreviation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accession_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `contains_human_dna` tinyint(1) DEFAULT NULL COMMENT 'Lane may contain human DNA',
  `contaminated_human_dna` tinyint(1) DEFAULT NULL COMMENT 'Human DNA in the lane is a contaminant and should be removed',
  `data_release_strategy` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_sort_of_study` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ena_project_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `study_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `study_visibility` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ega_dac_accession_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `array_express_accession_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ega_policy_accession_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_timing` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_delay_period` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_release_delay_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remove_x_and_autosomes` tinyint(1) NOT NULL DEFAULT '0',
  `aligned` tinyint(1) NOT NULL DEFAULT '1',
  `separate_y_chromosome_data` tinyint(1) NOT NULL DEFAULT '0',
  `data_access_group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prelim_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The preliminary study id prior to entry into the LIMS',
  `hmdmc_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The Human Materials and Data Management Committee approval number(s) for the study.',
  `data_destination` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The data destination type(s) for the study. It could be ''standard'', ''14mg'' or ''gseq''. This may be extended, if Sanger gains more external customers. It can contain multiply destinations separated by a space.',
  `s3_email_list` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_deletion_period` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_study_tmp`),
  UNIQUE KEY `study_id_lims_id_study_lims_index` (`id_lims`,`id_study_lims`),
  UNIQUE KEY `study_uuid_study_lims_index` (`uuid_study_lims`),
  KEY `study_accession_number_index` (`accession_number`),
  KEY `study_name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study_users`
--

DROP TABLE IF EXISTS `study_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `study_users` (
  `id_study_users_tmp` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal to this database id, value can change',
  `id_study_tmp` int(10) unsigned NOT NULL COMMENT 'Study id, see "study.id_study_tmp"',
  `last_updated` datetime NOT NULL COMMENT 'Timestamp of last update',
  `role` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
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

-- Dump completed on 2018-12-10 15:13:16
INSERT INTO schema_migrations (version) VALUES ('20141113110635');

INSERT INTO schema_migrations (version) VALUES ('20141113130813');

INSERT INTO schema_migrations (version) VALUES ('20141120101916');

INSERT INTO schema_migrations (version) VALUES ('20141120123833');

INSERT INTO schema_migrations (version) VALUES ('20150113120636');

INSERT INTO schema_migrations (version) VALUES ('20150113134336');

INSERT INTO schema_migrations (version) VALUES ('20150113142419');

INSERT INTO schema_migrations (version) VALUES ('20150401132814');

INSERT INTO schema_migrations (version) VALUES ('20150401145741');

INSERT INTO schema_migrations (version) VALUES ('20150401150636');

INSERT INTO schema_migrations (version) VALUES ('20150601112933');

INSERT INTO schema_migrations (version) VALUES ('20150813094119');

INSERT INTO schema_migrations (version) VALUES ('20150813122539');

INSERT INTO schema_migrations (version) VALUES ('20150813125229');

INSERT INTO schema_migrations (version) VALUES ('20150819120400');

INSERT INTO schema_migrations (version) VALUES ('20150827140317');

INSERT INTO schema_migrations (version) VALUES ('20150917082634');

INSERT INTO schema_migrations (version) VALUES ('20150917100509');

INSERT INTO schema_migrations (version) VALUES ('20151110102754');

INSERT INTO schema_migrations (version) VALUES ('20151127094701');

INSERT INTO schema_migrations (version) VALUES ('20160120155501');

INSERT INTO schema_migrations (version) VALUES ('20160420084130');

INSERT INTO schema_migrations (version) VALUES ('20160422095926');

INSERT INTO schema_migrations (version) VALUES ('20160621125538');

INSERT INTO schema_migrations (version) VALUES ('20160810093024');

INSERT INTO schema_migrations (version) VALUES ('20160919144230');

INSERT INTO schema_migrations (version) VALUES ('20170412135215');

INSERT INTO schema_migrations (version) VALUES ('20170427123459');

INSERT INTO schema_migrations (version) VALUES ('20170601102958');

INSERT INTO schema_migrations (version) VALUES ('20170608082257');

INSERT INTO schema_migrations (version) VALUES ('20170717092510');

INSERT INTO schema_migrations (version) VALUES ('20170717093707');

INSERT INTO schema_migrations (version) VALUES ('20170816121503');

INSERT INTO schema_migrations (version) VALUES ('20171005105857');

INSERT INTO schema_migrations (version) VALUES ('20180222132523');

INSERT INTO schema_migrations (version) VALUES ('20180510132219');

INSERT INTO schema_migrations (version) VALUES ('20180511093531');

INSERT INTO schema_migrations (version) VALUES ('20180731122912');

INSERT INTO schema_migrations (version) VALUES ('20180731142628');

INSERT INTO schema_migrations (version) VALUES ('20180821113540');

INSERT INTO schema_migrations (version) VALUES ('20181016142505');

INSERT INTO schema_migrations (version) VALUES ('20181210145626');

