require 'spec_helper'

describe QcResult do
  let!(:mock_sample) { create :sample }
  let(:example_lims) { 'example' }

  context 'with aliquots' do
    let(:expected_entries) { 1 }
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
        'last_updated' => '2018-04-12 11:11:11',
        'aliquots' => [{
          'id_library_lims' => 'NT10369L',
          'sample_uuid' => '000000-0000-0000-0000-0000000000'
        }] }
    end

    it 'saves the correct resource' do
      expect(described_class.create_or_update_from_json(json, example_lims)).to be_truthy
    end

    it_behaves_like 'a nested resource'
  end

  context 'without aliquots' do
    let(:expected_entries) { 0 }
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
        'last_updated' => '2018-04-12 11:11:11',
        'aliquots' => [] }
    end

    it 'saves the correct resource' do
      expect(described_class.create_or_update_from_json(json, example_lims)).to be_truthy
    end

    it_behaves_like 'a nested resource'
  end

  context 'when checking indexes' do
    it 'has an index on id_qc_result_lims and :id_lims' do
      expect(
        ActiveRecord::Base.connection.index_exists?(
          :qc_result, [:id_qc_result_lims, :id_lims], name: 'lookup_index'
        )
      ).to be_truthy
    end

    it 'has an index on id_library_lims' do
      expect(
        ActiveRecord::Base.connection.index_exists?(
          :qc_result, :id_library_lims, name: 'qc_result_id_library_lims_index'
        )
      ).to be_truthy
    end
  end
end
