# frozen_string_literal: true

require 'spec_helper'

describe StockResource do
  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample
    mock_study
  end

  shared_examples_for 'a stock resource' do
    it_behaves_like 'maps JSON fields', {}

    it_behaves_like 'ignores JSON fields', []

    it_behaves_like 'belongs to', %i[
      sample
      study
    ], [:samples]

    it_behaves_like 'a nested resource'
  end

  context 'for a well' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 1 }

    it_behaves_like 'a stock resource'

    let(:json) do
      {
        'created_at' => '2012-03-11 10:22:42',
        'updated_at' => '2012-03-11 10:22:42',

        'samples' => [
          {
            'sample_uuid' => '000000-0000-0000-0000-0000000000',
            'study_uuid' => '000000-0000-0000-0000-0000000001'
          }
        ],

        'stock_resource_id' => '12345',
        'stock_resource_uuid' => '000000-0000-0000-0000-0000000002',

        # We don't validate the barcode format, other
        # LIMS might use different standards
        'labware_machine_barcode' => '1220456987123',
        'labware_human_barcode' => 'DN456987D',
        'labware_coordinate' => 'A1',
        'labware_type' => 'well',

        'current_volume' => 1.23,
        'initial_volume' => 4.56,
        'concentration' => 23.56,

        'gel_pass' => 'Pass',
        'pico_pass' => 'Pass',
        'snp_count' => 2,
        'measured_gender' => 'Unknown'

      }
    end

    context 'when update with identical tag indexes' do
      let(:example_lims) { 'example' }

      let(:updated_json) do
        updated_json = json.deep_dup
        updated_json['current_volume'] = 1.00
        # Use a later timestamp so update-in-place logic actually works.
        updated_json['updated_at'] = '2012-03-11 10:22:43'
        updated_json
      end

      it 'reuses the existing records' do
        described_class.create_or_update_from_json(json, example_lims)
        original_ids = described_class.pluck(:id_stock_resource_tmp, :id_sample_tmp)
        described_class.create_or_update_from_json(updated_json, example_lims)
        new_ids = described_class.pluck(:id_stock_resource_tmp, :id_sample_tmp)
        expect(new_ids).to eq(original_ids)
        expect(described_class.last.current_volume).to eq(1.00)
      end
    end
  end

  context 'for a well with SS formatted data' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 1 }

    it_behaves_like 'a stock resource'

    let(:json) do
      {
        'created_at' => '2012-03-11T10:22:42+00:00',
        'updated_at' => '2012-03-11T10:22:42+00:00',

        'samples' => [
          {
            'sample_uuid' => '000000-0000-0000-0000-0000000000',
            'study_uuid' => '000000-0000-0000-0000-0000000001'
          }
        ],

        'stock_resource_id' => 12_345,
        'stock_resource_uuid' => '000000-0000-0000-0000-0000000002',

        # We don't validate the barcode format, other
        # LIMS might use different standards
        'machine_barcode' => '1220456987123',
        'human_barcode' => 'DN456987D',
        'labware_coordinate' => 'A1',
        'labware_type' => 'well',

        'current_volume' => 1.23,
        'initial_volume' => 4.56,
        'concentration' => 23.56,

        'gel_pass' => 'Pass',
        'pico_pass' => 'Pass',
        'snp_count' => 2,
        'measured_gender' => 'Unknown'

      }
    end

    context 'when the message contains internal *_tmp ids' do
      # Incoming internal *_tmp ids must be ignored/stripped from the message.
      # The record resolves sample/study from sample_uuid/study_uuid and
      # persists database-derived foreign keys.
      let(:example_lims) { 'example' }
      let(:incoming_id_sample_tmp) { mock_sample.id_sample_tmp + 10_000 }
      let(:incoming_id_study_tmp) { mock_study.id_study_tmp + 10_000 }
      let(:incoming_id_stock_resource_tmp) { 10_000 }

      let(:json) do
        {
          'created_at' => '2012-03-11T10:22:42+00:00',
          'updated_at' => '2012-03-11T10:22:42+00:00',
          'samples' => [
            {
              'id_stock_resource_tmp' => incoming_id_stock_resource_tmp, # This must be ignored.
              'id_sample_tmp' => incoming_id_sample_tmp, # This must be ignored.
              'id_study_tmp' => incoming_id_study_tmp,   # This must be ignored.
              'sample_uuid' => mock_sample.uuid_sample_lims,
              'study_uuid' => mock_study.uuid_study_lims
            }
          ],
          'stock_resource_id' => 12_345,
          'stock_resource_uuid' => '000000-0000-0000-0000-0000000002',
          'machine_barcode' => '1220456987123',
          'human_barcode' => 'DN456987D',
          'labware_coordinate' => 'A1',
          'labware_type' => 'well'
        }
      end

      context 'when creating' do
        it 'uses the internal ids from the database and ignores the incoming internal ids' do
          described_class.create_or_update_from_json(json, example_lims)

          stock_resource = described_class.last
          expect(stock_resource.id_stock_resource_tmp).not_to eq(incoming_id_stock_resource_tmp)
          expect(stock_resource.id_sample_tmp).to eq(mock_sample.id_sample_tmp)
          expect(stock_resource.id_sample_tmp).not_to eq(incoming_id_sample_tmp)
          expect(stock_resource.id_study_tmp).to eq(mock_study.id_study_tmp)
          expect(stock_resource.id_study_tmp).not_to eq(incoming_id_study_tmp)
          expect(stock_resource.sample).to eq(mock_sample)
          expect(stock_resource.study).to eq(mock_study)
        end

        it 'raises if sample_uuid does not resolve and ignores incoming id_sample_tmp' do
          # Warren delay path.
          json['samples'][0]['sample_uuid'] = 'non-existent-sample-uuid'

          expect do
            described_class.create_or_update_from_json(json, example_lims)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'raises if sample_uuid is missing and ignores incoming id_sample_tmp' do
          # Warren dead-letter path.
          json['samples'][0].delete('sample_uuid')

          expect do
            described_class.create_or_update_from_json(json, example_lims)
          end.to raise_error(ActiveRecord::NotNullViolation)
        end
      end

      context 'when updating' do
        it 'updates record with the internal ids from the database and ignores incoming internal ids' do
          described_class.create_or_update_from_json(json, example_lims)
          original_stock_resource = described_class.last

          updated_json = json.deep_dup
          # The updated_at must be later than the original for the update to occur.
          updated_json['updated_at'] = (original_stock_resource.last_updated + 1.second).iso8601
          updated_json['current_volume'] = 5.43

          described_class.create_or_update_from_json(updated_json, example_lims)
          updated_stock_resource = described_class.last

          expect(described_class.count).to eq(1)
          expect(updated_stock_resource.id_stock_resource_tmp).to eq(original_stock_resource.id_stock_resource_tmp)
          expect(updated_stock_resource.id_stock_resource_tmp).not_to eq(incoming_id_stock_resource_tmp)
          expect(updated_stock_resource.id_stock_resource_lims).to eq(original_stock_resource.id_stock_resource_lims)
          expect(updated_stock_resource.id_sample_tmp).to eq(mock_sample.id_sample_tmp)
          expect(updated_stock_resource.id_sample_tmp).not_to eq(incoming_id_sample_tmp)
          expect(updated_stock_resource.id_study_tmp).to eq(mock_study.id_study_tmp)
          expect(updated_stock_resource.id_study_tmp).not_to eq(incoming_id_study_tmp)
          expect(updated_stock_resource.current_volume).to eq(5.43)
          expect(updated_stock_resource.last_updated).to be > original_stock_resource.last_updated
        end

        it 'reuses existing records for multiple sample entries and ignores incoming internal ids' do
          second_sample = create(:sample, :with_uuid_sample_lims)
          second_study = create(:study, :with_uuid_study_lims)

          multi_sample_json = json.deep_dup
          multi_sample_json['samples'] = [
            {
              'id_stock_resource_tmp' => incoming_id_stock_resource_tmp,
              'id_sample_tmp' => incoming_id_sample_tmp,
              'id_study_tmp' => incoming_id_study_tmp,
              'sample_uuid' => mock_sample.uuid_sample_lims,
              'study_uuid' => mock_study.uuid_study_lims
            },
            {
              'id_stock_resource_tmp' => incoming_id_stock_resource_tmp + 1,
              'id_sample_tmp' => second_sample.id_sample_tmp + 10_000,
              'id_study_tmp' => second_study.id_study_tmp + 10_000,
              'sample_uuid' => second_sample.uuid_sample_lims,
              'study_uuid' => second_study.uuid_study_lims
            }
          ]

          described_class.create_or_update_from_json(multi_sample_json, example_lims)

          original_rows = described_class.order(:id_sample_tmp).pluck(:id_stock_resource_tmp, :id_sample_tmp)
          expect(original_rows.length).to eq(2)

          updated_json = multi_sample_json.deep_dup
          updated_json['updated_at'] = (described_class.last.last_updated + 1.second).iso8601
          updated_json['current_volume'] = 7.89

          described_class.create_or_update_from_json(updated_json, example_lims)

          updated_rows = described_class.order(:id_sample_tmp).pluck(:id_stock_resource_tmp, :id_sample_tmp)
          expect(updated_rows).to eq(original_rows)
          expect(described_class.count).to eq(2)
          expect(described_class.order(:id_sample_tmp).pluck(:current_volume).uniq).to eq([7.89])
        end
      end
    end
  end

  context 'for a tube' do
    let(:expected_entries) { 1 }

    let(:json) do
      {
        'created_at' => '2012-03-11 10:22:42',
        'updated_at' => '2012-03-11 10:22:42',

        'samples' => [
          {
            'sample_uuid' => '000000-0000-0000-0000-0000000000',
            'study_uuid' => '000000-0000-0000-0000-0000000001'
          }
        ],

        'stock_resource_id' => '12345',
        'stock_resource_uuid' => '000000-0000-0000-0000-0000000002',

        # We don't validate the barcode format, other
        # LIMS might use different standards
        'machine_barcode' => '3040456987123',
        'human_barcode' => 'NT456987D',
        'labware_type' => 'tube'

        # QC data will not always be present, especially for tubes
        # So lets make sure its absence doesn't cause issues

      }
    end
  end
end
