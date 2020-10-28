# frozen_string_literal: true

require 'spec_helper'

describe SamplesExtractionActivity do
  it_behaves_like 'a nested resource'
  let(:expected_entries) { 2 }

  # it_behaves_like 'maps JSON fields', {
  #   pac_bio_run_id: :id_pac_bio_run_lims
  # }

  it_behaves_like 'belongs to', [
    :sample
  ], [:samples]

  let!(:mock_sample) { create(:sample) }
  let!(:mock_sample_b) { create(:sample, uuid_sample_lims: SecureRandom.uuid, id_sample_lims: 2) }
  let!(:mock_study) { create(:study) }

  let(:json) do
    {
      'samples' => [
        { 'sample_uuid' => mock_sample.uuid_sample_lims, 'input_barcode' => 'DN29', 'output_barcode' => 'DN25' },
        { 'sample_uuid' => mock_sample_b.uuid_sample_lims, 'input_barcode' => 'DN29', 'output_barcode' => 'DN25' }
      ],
      'activity_type' => 'Illumina Extraction',
      'instrument' => 'Instument',
      'kit_barcode' => 'DN26',
      'kit_type' => 'Kit type',
      'completed_at' => '2020-10-28T08:42:56.000Z',
      'updated_at' => '2020-10-28T08:42:56.000Z',
      'user' => 'Users name',
      'activity_id' => 2006
    }
  end
end
