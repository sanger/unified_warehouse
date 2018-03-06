shared_examples 'fluidigm json' do
  let(:json) do
    {
      "id_flgen_plate_lims" => "1123",
      "plate_barcode_lims" => 111,
      "plate_barcode" => 111,
      "plate_uuid_lims" => "000000-0000-0000-0000-0000000000",
      "plate_size" => "96",
      "cost_code" => "2222",
      "wells" => [
        {
          "well_label" => "S01",
          "well_uuid_lims" => "000000-0000-0000-0000-0000000000",
          "cost_code" => "cost_code1",
          "sample_uuid" => '000000-0000-0000-0000-0000000000',
          "study_uuid" => '000000-0000-0000-0000-0000000001',
          "qc_state" => 1,
          "last_updated" => "2012-03-11 10:22:42"
        },
        {
          "well_label" => "S02",
          "well_uuid_lims" => "000000-0000-0000-0000-0000000000",
          "sample_uuid" => '000000-0000-0000-0000-0000000000',
          "study_uuid" => '000000-0000-0000-0000-0000000001',
          "cost_code" => "cost_code1",
          "qc_state" => 1,
          "last_updated" => "2012-03-11 10:22:42"
        }
      ]
    }
  end
end

shared_examples 'full flowcell json' do
  let(:json) do
    {

      "flowcell_barcode" => "12345678903",
      "flowcell_id" => 1123,
      "forward_read_length" => 222,
      "reverse_read_length" => 222,

      "updated_at" => "2012-03-11 10:22:42",

      "lanes" => [
        {
          "manual_qc" => false,
          "entity_type" => "library",
          "position" => 1,
          "priority" => 1,
          "id_pool_lims" => "DN324095D A1:H2",
          "external_release" => true,
          "purpose" => "standard",

          "samples" => [
            {
              "tag_index" => 3,
              "tag_sequence" => "ATAG",
              "tag_set_id_lims" => "2",
              "tag_set_name" => "Sanger_168tags - 10 mer tags",
              "tag_identifier" => 1,
              "tag2_sequence" => "GGGG",
              "tag2_set_id_lims" => "1",
              "tag2_set_name" => "Tag 2 Set 1",
              "tag2_identifier" => 1,
              "pipeline_id_lims" => "Agilent Pulldown",
              "entity_type" => "library_indexed",
              "bait_name" => "DDD_V5_plus",
              "requested_insert_size_from" => 100,
              "requested_insert_size_to" => 200,
              "sample_uuid" => "000000-0000-0000-0000-0000000000",
              "study_uuid" => "000000-0000-0000-0000-0000000001",
              "cost_code" => "12345",
              "entity_id_lims" => 12345,
              "is_r_and_d" => false,
              "primer_panel" => 'PrimerPanel1'
            }
          ],
          "controls" => [
            {
              "sample_uuid" => "000000-0000-0000-0000-0000000000",
              "tag_index" => 168,
              "entity_type" => "library_indexed_spike",
              "tag_sequence" => "ATAG",
              "tag_set_id_lims" => "2",
              "entity_id_lims" => "12345",
              "tag_set_name" => "Sanger_168tags - 10 mer tags"
            }
          ]
        }
      ]
    }
  end
end

shared_examples 'sample json' do
  let(:json) do
    {
      "uuid" => "11111111-2222-3333-4444-555555555555",
      "id" => 1,
      "name" => "name",
      "reference_genome" => "reference genome",
      "organism" => "organism",
      "phenotype" => "healthy",
      "consent_withdrawn" => true,
      "sample_ebi_accession_number" => "accession number",
      "sample_common_name" => "common name",
      "sample_description" => "description",
      "sample_taxon_id" => "taxon id",
      "father" => "father",
      "mother" => "mother",
      "replicate" => "replicate",
      "ethnicity" => "ethnicity",
      "gender" => "gender",
      "cohort" => "cohort",
      "country_of_origin" => "country of origin",
      "geographical_region" => "geographical region",
      "updated_at" => "2012-03-11 10:22:42",
      "created_at" => "2012-03-11 10:22:42",
      "sanger_sample_id" => "sanger sample id",
      "control" => true,
      "empty_supplier_sample_name" => true,
      "supplier_name" => "supplier name",
      "sample_public_name" => "public name",
      "sample_sra_hold" => "sample visibility",
      "sample_strain_att" => "strain",
      "updated_by_manifest" => true,
      "sample_tubes" => "Ignore this field",
      "donor_id" => '11111111-2222-3333-4444-555555555556'
    }
  end
end
