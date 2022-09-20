# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LongReadQcResult, type: :model do
  let(:example_lims) { 'example' }

  context 'create_or_update_from_json' do
    let(:json) do
      {
        'labware_barcode' => 'barcode placeholder',
        'sample_id' => '1b67b801-4f9a-4c99-8923-9d0a683a8af8',
        'assay_type' => 'dummy',
        'assay_type_key' => 'abc',
        'value' => '112',
        'id_lims' => 'dummy',
        'id_long_read_qc_result_lims' => 'abc',
        'created' => '2022-09-13T09:38:32+00:00',
        'last_updated' => '2022-09-14T09:12:41+01:00',
        'recorded_at' => '2022-09-15T09:12:41+01:00'
      }
    end

    it 'saves the correct resource' do
      expect(described_class.create_or_update_from_json(json, example_lims)).to be_truthy
    end
  end
end
