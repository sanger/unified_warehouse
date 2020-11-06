# frozen_string_literal: true

require 'spec_helper'

describe BmapFlowcell do
  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }
  let(:example_lims) { 'example' }
  let(:expected_entries) { 1 }
  let(:json) do
    {
      'sample_uuid' => mock_sample.uuid_sample_lims,
      'study_uuid' => mock_study.uuid_study_lims,
      'last_updated' => '2018-04-12 11:11:11',
      'recorded_at' => '2012-03-11 10:22:42',
      'experiment_name' => 'experiment-1',
      'instrument_name' => 'clive',
      'enzyme_name' => 'DLE-1',
      'chip_barcode' => 'FLEVEAOLPTOWPNWU20319131581014320190911XXXXXXXXXXXXX',
      'chip_serialnumber' => 'FLEVEAOLPTOWPNWU',
      'position' => '1',
      'id_flowcell_lims' => '123',
      'id_library_lims' => '456',
      'id_lims' => 'TRAC'
    }
  end

  before(:each) do
    mock_sample
    mock_study
  end

  it_behaves_like 'belongs to', %i[study sample], nil

  it 'saves the correct resource' do
    expect(described_class.create_or_update_from_json(json, example_lims)).to be_truthy
  end
end
