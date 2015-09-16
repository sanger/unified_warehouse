require 'spec_helper'

describe Flowcell do

  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample; mock_study
  end

  shared_examples_for 'a flowcell' do

    it_behaves_like 'maps JSON fields', {
     :flowcell_id => :id_flowcell_lims
    }

    it_behaves_like 'ignores JSON fields', [
    ]

    it_behaves_like 'belongs to', [
      :study,
      :sample
    ], { :lanes => :samples }

    it_behaves_like 'a nested resource'
  end

  context 'with controls and all optional fields' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 2 }

    it_behaves_like 'belongs to', [
      :sample
    ], {:lanes => :controls }

    it_behaves_like 'a flowcell'

    let(:json) do
      {

        "flowcell_barcode" => "12345678903",
        "flowcell_id" => "1123",
        "forward_read_length" => 222,
        "reverse_read_length" => 222,

        "updated_at" => "2012-03-11 10:22:42",

        "lanes" => [
          {
            "manual_qc" => true,
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
                "entity_id_lims" => "12345",
                "is_r_and_d" => false
              }
            ],
            "controls" => [
              {
                "sample_uuid" => "000000-0000-0000-0000-0000000000",
                "tag_index" => 3,
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

    it 'flags all entries as spiked' do
      Flowcell.all.each {|fc| expect(fc.spiked).to be_true }
    end
  end


  context 'without controls or other optional fields' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 1 }

    it_behaves_like 'a flowcell'

    let(:json) do
      {

        "flowcell_barcode" => "12345678903",
        "flowcell_id" => "1123",
        "pipeline_id_lims" => "Agilent Pulldown",
        "forward_read_length" => 222,
        "reverse_read_length" => 222,

        "updated_at" => "2012-03-11 10:22:42",

        "lanes" => [
          {
            "manual_qc" => true,
            "entity_type" => "library",
            "position" => 1,
            "priority" => 1,
            "id_pool_lims" => "DN324095D A1:H2",
            "external_release" => true,

            "samples" => [
              {
                "tag_index" => 3,
                "tag_sequence" => "ATAG",
                "tag_set_id_lims" => "2",
                "tag_set_name" => "Sanger_168tags - 10 mer tags",
                "bait_name" => "DDD_V5_plus",
                "requested_insert_size_from" => 100,
                "requested_insert_size_to" => 200,
                "sample_uuid" => "000000-0000-0000-0000-0000000000",
                "study_uuid" => "000000-0000-0000-0000-0000000001",
                "cost_code" => "12345",
                "entity_id_lims" => "12345",
                "is_r_and_d" => false
              }
            ]
          }
        ]
      }
    end

    it 'flags all entries as not-spiked' do
      Flowcell.all.each {|fc| expect(fc.spiked).to be_false }
    end
  end
end
