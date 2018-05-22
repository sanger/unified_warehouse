require 'spec_helper'

describe QcResult do
  let!(:mock_sample) { create :sample }
  let(:example_lims) { 'example' }
  let(:json) do
    { 'id_qc_result_lims' => '123',
      'assay'        => 'qPCR 1.0',
      'value'        => '5.43',
      'units'        => 'nM',
      'cv'           => 2.34,
      'qc_type'      => 'Molarity',
      'id_pool_lims' => 'NT10369L',
      'labware_purpose' => 'Stock Plate',
      'date_created' => '2012-03-11 10:22:42',
      'date_updated' => '2018-04-12 11:11:11',
      'aliquots' => [{
        'id_library_lims' => 'NT10369L',
        'sample_uuid' => '000000-0000-0000-0000-0000000000'
      }] }
  end

  before(:each) do
    mock_sample
  end

  it 'saves the correct resource' do
    expect(described_class.create_or_update_from_json(json, example_lims)).to be_truthy
  end
end
