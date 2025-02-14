# frozen_string_literal: true

require 'spec_helper'

describe OseqFlowcellRun do
  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }
  let(:expected_entries) { 3 }

  before(:each) do
    mock_sample
    mock_study
  end

  it_behaves_like 'a nested resource'

  it_behaves_like 'belongs to', %i[
    study
    sample
  ], flowcells: :samples

  let(:json) do
    {
      'experiment_name' => 'ontrun-03',
      'instrument_name' => 'Instrument',
      'pipeline_id_lims' => 'Rapid',
      'last_updated' => '2017-08-25T09:30:28.133Z',
      'requested_data_type' => 'basecalls',
      'run_uuid' => 'd14beaef-05f5-4e76-a9b8-20b656ca7ad1',
      'flowcells' => [
        {
          'id_flowcell_lims' => '000000-0000-0000-0000-0000000005',
          'instrument_slot' => 1,
          'flowcell_id' => 'FAV1234',
          'samples' => [
            {
              'sample_uuid' => '000000-0000-0000-0000-0000000000',
              'study_uuid' => '000000-0000-0000-0000-0000000001',
              'tag_identifier' => '1',
              'tag_sequence' => 'ACTG',
              'tag_set_id_lims' => '1',
              'tag_set_name' => 'tag_set_1',
              'tag2_identifier' => '1',
              'tag2_sequence' => 'GTCA',
              'tag2_set_id_lims' => '2',
              'tag2_set_name' => 'tag_set_2',
              'library_tube_uuid' => '1accf7cb-2ee8-4528-8c0a-408b94cfb1de',
              'library_tube_barcode' => 'TRAC1234567',
              run_id: 'abcdefghijklmnop1234567890qrst',
              rebascalling_process: 'rebasecalling_process'
            },
            {
              'sample_uuid' => '000000-0000-0000-0000-0000000000',
              'study_uuid' => '000000-0000-0000-0000-0000000001',
              'tag_identifier' => '2',
              'tag_sequence' => 'TACG',
              'tag_set_id_lims' => '1',
              'tag_set_name' => 'tag_set_1',
              'tag2_identifier' => '2',
              'tag2_sequence' => 'GATC',
              'tag2_set_id_lims' => '2',
              'tag2_set_name' => 'tag_set_2',
              'library_tube_uuid' => '1accf7cb-2ee8-4528-8c0a-408b94cfb1de',
              'library_tube_barcode' => 'TRAC1234567',
              run_id: 'abcdefghijklmnop1234567890qrst',
              rebascalling_process: 'rebasecalling_process'
            }
          ]
        },
        {
          'id_flowcell_lims' => '000000-0000-0000-0000-0000000010',
          'instrument_slot' => 3,
          'flowcell_id' => 'FAV1234',
          'samples' => [
            {
              'sample_uuid' => '000000-0000-0000-0000-0000000000',
              'study_uuid' => '000000-0000-0000-0000-0000000001',
              'tag_identifier' => '1',
              'tag_sequence' => 'ACTG',
              'tag_set_id_lims' => '1',
              'tag_set_name' => 'tag_set_1',
              'tag2_identifier' => '1',
              'tag2_sequence' => 'GTCA',
              'tag2_set_id_lims' => '2',
              'tag2_set_name' => 'tag_set_2',
              'library_tube_uuid' => '1accf7cb-2ee8-4528-8c0a-408b94cfb1de',
              'library_tube_barcode' => 'TRAC1234567'
            }
          ]
        },
        {
          'id_flowcell_lims' => '000000-0000-0000-0000-0000000015',
          'instrument_slot' => 5,
          'flowcell_id' => 'FAV1234',
          'samples' => []
        }
      ]
    }
  end
end
