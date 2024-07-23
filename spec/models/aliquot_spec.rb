# frozen_string_literal: true

require 'spec_helper'

describe Aliquot do
  context 'aliquot' do
    let(:example_lims) { 'example' }

    let(:json) do
      { 'id_lims' => 'example',
        'aliquot_type' => 'DNA',
        'volume' => 5.43,
        'concentration' => 2.34,
        'insert_size' => 100,
        'id_aliquot_lims' => '2',
        'source_type' => 'library',
        'source_barcode' => 'PR-rna-00000001_H12',
        'sample_name' => 'aliquot-sample',
        'used_by_type' => 'pool',
        'used_by_barcode' => 'pool-barcode',
        'last_updated' => '2012-03-11 10:20:08',
        'recorded_at' => '2012-03-11 10:20:08',
        'created_at' => '2012-03-11 10:20:08' }
    end

    it 'saves the correct resource' do
      expect(described_class.create_or_update_from_json(json, example_lims)).to be_truthy
    end
  end
end
