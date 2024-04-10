# frozen_string_literal: true

require 'spec_helper'

describe Aliquot do
  context 'aliquots' do
    let(:json) do
      { 'id' => 1,
        'id_lims' => 'example',
        'aliquot_type' => 'DNA',
        'volume' => 5.43,
        'concentration' => 2.34,
        'lims_uuid' => '000000-0000-0000-0000-0000000002',
        'source_type' => 'library',
        'source_barcode' => 'PR-rna-00000001_H12',
        'sample_name' => 'aliquot-sample',
        'used_by_type' => 'pool',
        'used_by_barcode' => 'pool-barcode',
        'last_updated' => '2012-03-11 10:20:08',
        'created' => '2012-03-11 10:20:08' }
    end
    it_behaves_like 'a singular resource'
  end
end
