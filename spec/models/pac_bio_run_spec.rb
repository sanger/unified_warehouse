# frozen_string_literal: true

require 'spec_helper'

describe PacBioRun do
  it_behaves_like 'a nested resource'

  # We have a row for the lane, the sample and the control
  let(:expected_entries) { 3 }

  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample
    mock_study
  end

  it_behaves_like 'maps JSON fields', {
    pac_bio_run_id: :id_pac_bio_run_lims
  }

  it_behaves_like 'belongs to', %i[
    sample
    study
  ], { wells: :samples }

  let(:json) do
    {
      'pac_bio_run_id' => '12345',
      'pac_bio_run_name' => '12345',
      'pac_bio_run_uuid' => '000000-0000-0000-0000-0000000005',
      'plate_barcode' => 'DN12345T',
      'plate_uuid_lims' => '000000-0000-0000-0000-0000000000',
      'last_updated' => '2012-03-11 10:22:42',
      'wells' => [
        {
          'well_label' => 'A1',
          'well_uuid_lims' => '000000-0000-0000-0000-0000000000',
          'samples' => [
            {
              'sample_uuid' => '000000-0000-0000-0000-0000000000',
              'pac_bio_library_tube_id_lims' => '12345',
              'pac_bio_library_tube_uuid' => '000000-0000-0000-0000-0000000000',
              'pac_bio_library_tube_name' => 'example',
              'tag_identifier' => 3,
              'tag_sequence' => 'ATAG',
              'tag_set_id_lims' => '2',
              'cost_code' => 'cost_code1',
              'tag_set_name' => 'Sanger_168tags - 10 mer tags',
              'study_uuid' => '000000-0000-0000-0000-0000000001',
              'tag2_identifier' => '1',
              'tag2_sequence' => 'GTCA',
              'tag2_set_id_lims' => '2',
              'tag2_set_name' => 'tag_set_2',
              'pipeline_id_lims' => 'IsoSeq'
            },
            {
              'sample_uuid' => '000000-0000-0000-0000-0000000000',
              'pac_bio_library_tube_id_lims' => '12345',
              'pac_bio_library_tube_uuid' => '000000-0000-0000-0000-0000000000',
              'pac_bio_library_tube_name' => 'example',
              'tag_identifier' => 4,
              'tag_sequence' => 'TACG',
              'tag_set_id_lims' => '2',
              'cost_code' => 'cost_code1',
              'tag_set_name' => 'Sanger_168tags - 10 mer tags',
              'study_uuid' => '000000-0000-0000-0000-0000000001',
              'tag2_identifier' => '1',
              'tag2_sequence' => 'GTCA',
              'tag2_set_id_lims' => '2',
              'tag2_set_name' => 'tag_set_2'
            }
          ]
        },
        {
          'well_label' => 'B2',
          'well_uuid_lims' => '000000-0000-0000-0000-0000000000',
          'samples' => [
            {
              'sample_uuid' => '000000-0000-0000-0000-0000000000',
              'pac_bio_library_tube_id_lims' => '12345',
              'pac_bio_library_tube_uuid' => '000000-0000-0000-0000-0000000000',
              'pac_bio_library_tube_name' => 'example',
              'tag_identifier' => 3,
              'tag_sequence' => 'ATAG',
              'tag_set_id_lims' => '2',
              'cost_code' => 'cost_code1',
              'tag_set_name' => 'Sanger_168tags - 10 mer tags',
              'study_uuid' => '000000-0000-0000-0000-0000000001'
            }
          ]
        },
        {
          'well_label' => 'C1',
          'well_uuid_lims' => '000000-0000-0000-0000-0000000000',
          'samples' => []
        }
      ]
    }
  end
end
