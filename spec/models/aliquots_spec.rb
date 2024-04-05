# frozen_string_literal: true

require 'spec_helper'

describe Aliquot, type: :model do
  context 'create aliquots' do
    it 'saves correct aliquot' do
      expect(described_class.create(lims_source: 'library',
                                    lims_uuid: '000000-0000-0000-0000-0000000002',
                                    aliquot_type: 'derivative',
                                    source_type: 'library',
                                    source_barcode: 'PR-rna-00000001_H12',
                                    sample_name: 'aliquot-sample',
                                    used_by_type: 'pool',
                                    used_by_barcode: 'pool-barcode',
                                    volume: 24.98589115)).to be_truthy
    end
  end
end
