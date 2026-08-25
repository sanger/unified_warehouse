# frozen_string_literal: true

require 'spec_helper'

describe Flowcell do
  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample
    mock_study
  end

  shared_examples_for 'a flowcell' do
    it_behaves_like 'maps JSON fields', {
      flowcell_id: :id_flowcell_lims
    }

    it_behaves_like 'ignores JSON fields', []

    it_behaves_like 'belongs to', %i[
      study
      sample
    ], { lanes: :samples }

    it_behaves_like 'a nested resource'
  end

  context 'with controls and all optional fields' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 2 }

    it_behaves_like 'belongs to', [
      :sample
    ], { lanes: :controls }

    it_behaves_like 'a flowcell'

    include_examples 'full flowcell json'

    it 'flags all entries as spiked' do
      Flowcell.find_each { |fc| expect(fc.spiked).to be_true }
    end

    context 'when update with identical tag indexes' do
      let(:example_lims) { 'example' }

      let(:updated_json) do
        updated_json = json
        updated_json['lanes'].first['manual_qc'] = true
        updated_json['updated_at'] = '2012-03-11 12:22:42'
        updated_json
      end

      it 'reuses the existing records' do
        described_class.create_or_update_from_json(json, example_lims)
        original_ids = described_class.all.map(&:id_iseq_flowcell_tmp)
        described_class.create_or_update_from_json(updated_json, example_lims)
        new_ids = described_class.all.map(&:id_iseq_flowcell_tmp)
        expect(new_ids).to eq(original_ids)
      end
    end

    context 'when update with different tag indexes' do
      let(:example_lims) { 'example' }

      let(:updated_json) do
        updated_json = json
        updated_json['lanes'].first['manual_qc'] = true
        updated_json['lanes'].first['samples'].first['tag_index'] = 4
        updated_json['updated_at'] = '2012-03-11 12:22:42'
        updated_json
      end

      it 'destroys the existing records' do
        described_class.create_or_update_from_json(json, example_lims)
        original_ids = described_class.all.map(&:id_iseq_flowcell_tmp)
        described_class.create_or_update_from_json(updated_json, example_lims)
        new_ids = described_class.all.map(&:id_iseq_flowcell_tmp)
        expect(new_ids).to_not eq(original_ids)
      end
    end
  end

  context 'without controls or other optional fields' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 1 }

    it_behaves_like 'a flowcell'

    let(:json) do
      {

        'flowcell_barcode' => '12345678903',
        'flowcell_id' => '1123',
        'pipeline_id_lims' => 'Agilent Pulldown',
        'forward_read_length' => 222,
        'reverse_read_length' => 222,

        'updated_at' => '2012-03-11 10:22:42',

        'lanes' => [
          {
            'manual_qc' => true,
            'entity_type' => 'library',
            'position' => 1,
            'priority' => 1,
            'id_pool_lims' => 'DN324095D A1:H2',
            'external_release' => true,

            'samples' => [
              {
                'tag_index' => 3,
                'tag_sequence' => 'ATAG',
                'tag_set_id_lims' => '2',
                'tag_set_name' => 'Sanger_168tags - 10 mer tags',
                'bait_name' => 'DDD_V5_plus',
                'requested_insert_size_from' => 100,
                'requested_insert_size_to' => 200,
                'sample_uuid' => '000000-0000-0000-0000-0000000000',
                'study_uuid' => '000000-0000-0000-0000-0000000001',
                'cost_code' => '12345',
                'entity_id_lims' => '12345',
                'is_r_and_d' => false
              }
            ]
          }
        ]
      }
    end

    it 'flags all entries as not-spiked' do
      Flowcell.find_each { |fc| expect(fc.spiked).to be_false }
    end
  end

  context 'when resolving study associations for incoming messages' do
    let(:example_lims) { 'example' }
    let(:study_uuid) { 'duplicate-study-uuid' }

    let(:json) do
      {
        'flowcell_barcode' => '12345678903',
        'flowcell_id' => '1123',
        'pipeline_id_lims' => 'Agilent Pulldown',
        'forward_read_length' => 222,
        'reverse_read_length' => 222,
        'updated_at' => '2012-03-11 10:22:42',
        'lanes' => [
          {
            'manual_qc' => true,
            'entity_type' => 'library',
            'position' => 1,
            'priority' => 1,
            'id_pool_lims' => 'DN324095D A1:H2',
            'external_release' => true,
            'samples' => [
              {
                'tag_index' => 3,
                'tag_sequence' => 'ATAG',
                'tag_set_id_lims' => '2',
                'tag_set_name' => 'Sanger_168tags - 10 mer tags',
                'bait_name' => 'DDD_V5_plus',
                'requested_insert_size_from' => 100,
                'requested_insert_size_to' => 200,
                'sample_uuid' => mock_sample.uuid_sample_lims,
                'study_uuid' => study_uuid,
                'cost_code' => '12345',
                'entity_id_lims' => '12345',
                'is_r_and_d' => false
              }
            ]
          }
        ]
      }
    end

    it 'links to the matching study when only one record is found' do
      matching_study = create(
        :study,
        uuid_study_lims: study_uuid,
        id_study_lims: '54321',
        is_current: true
      )

      described_class.create_or_update_from_json(json, example_lims)

      expect(described_class.last.study).to eq(matching_study)
    end

    it 'prefers study records where is_current is true when multiple uuid records match' do
      # Non-current match
      create(
        :study,
        uuid_study_lims: study_uuid,
        id_study_lims: '54322',
        is_current: false
      )
      current_match = create(
        :study,
        uuid_study_lims: study_uuid,
        id_study_lims: '54323',
        is_current: true
      )

      described_class.create_or_update_from_json(json, example_lims)

      expect(described_class.last.study).to eq(current_match)
    end

    it 'uses the last record when multiple current study records still remain' do
      # Create several matches
      3.times do |index|
        create(
          :study,
          uuid_study_lims: study_uuid,
          is_current: true,
          id_study_lims: "5432#{index}"
        )
      end
      last_current_match = create(
        :study,
        uuid_study_lims: study_uuid,
        id_study_lims: '54325',
        is_current: true
      )

      described_class.create_or_update_from_json(json, example_lims)

      expect(described_class.last.study).to eq(last_current_match)
    end

    it 'uses the last record when multiple non-current study records remain' do
      # Create several matches
      3.times do |index|
        create(
          :study,
          uuid_study_lims: study_uuid,
          is_current: false,
          id_study_lims: "5432#{index}"
        )
      end
      last_non_current_match = create(
        :study,
        uuid_study_lims: study_uuid,
        id_study_lims: '54325',
        is_current: false
      )

      described_class.create_or_update_from_json(json, example_lims)

      expect(described_class.last.study).to eq(last_non_current_match)
    end

    it 'uses the given id_lims and id_study_lims to find the study when no uuid is given' do
      id_study_lims = '54326'
      # Create a study with the same ID but a different LIMS ID to ensure the correct one is chosen
      create(:study, uuid_study_lims: nil, id_study_lims: id_study_lims, id_lims: 'Sapio')
      matching_study = create(
        :study,
        uuid_study_lims: nil,
        id_study_lims: id_study_lims,
        id_lims: example_lims
      )

      json['lanes'].first['samples'].first['study_uuid'] = nil
      json['lanes'].first['samples'].first['study_id'] = id_study_lims

      described_class.create_or_update_from_json(json, example_lims)

      expect(described_class.last.study).to eq(matching_study)
    end

    it 'raises an error when no matching study is found' do
      json['lanes'].first['samples'].first['study_uuid'] = 'nonexistent-uuid'

      expect do
        described_class.create_or_update_from_json(json, example_lims)
      end.to raise_error(ActiveRecord::RecordNotFound, "No study with uuid 'nonexistent-uuid'")
    end

    it 'raises an error when no matching study is found by id_lims and id_study_lims' do
      json['lanes'].first['samples'].first['study_uuid'] = nil
      json['lanes'].first['samples'].first['study_id'] = 'nonexistent-id'

      expect do
        described_class.create_or_update_from_json(json, example_lims)
      end.to raise_error(ActiveRecord::RecordNotFound, "No study for 'example' with_id 'nonexistent-id'")
    end
  end

  context 'a message with clashing samples' do
    let(:expected_identifiers) { 'tag_index, id_flowcell_lims, entity_id_lims, entity_type, position, tag_sequence, tag2_sequence' }
    let(:example_lims) { 'example' }

    let(:json) do
      {
        'flowcell_barcode' => '12345678903',
        'flowcell_id' => '1123',
        'pipeline_id_lims' => 'Agilent Pulldown',
        'forward_read_length' => 222,
        'reverse_read_length' => 222,
        'updated_at' => '2012-03-11 10:22:42',
        'lanes' => [
          {
            'manual_qc' => true,
            'entity_type' => 'library',
            'position' => 1,
            'priority' => 1,
            'id_pool_lims' => 'DN324095D A1:H2',
            'external_release' => true,
            'samples' => [
              {
                'tag_index' => 3,
                'tag_sequence' => 'ATAG',
                'tag_set_id_lims' => '2',
                'tag_set_name' => 'Sanger_168tags - 10 mer tags',
                'bait_name' => 'DDD_V5_plus',
                'requested_insert_size_from' => 100,
                'requested_insert_size_to' => 200,
                'sample_uuid' => '000000-0000-0000-0000-0000000000',
                'study_uuid' => '000000-0000-0000-0000-0000000001',
                'cost_code' => '12345',
                'entity_id_lims' => '12345',
                'is_r_and_d' => false
              },
              {
                'tag_index' => 3,
                'tag_sequence' => 'ATAG',
                'tag_set_id_lims' => '2',
                'tag_set_name' => 'Sanger_168tags - 10 mer tags',
                'bait_name' => 'SomethingElse',
                'requested_insert_size_from' => 400,
                'requested_insert_size_to' => 500,
                'sample_uuid' => '000000-0000-0000-0000-0000000000',
                'study_uuid' => '000000-0000-0000-0000-0000000001',
                'cost_code' => '12345',
                'entity_id_lims' => '12345',
                'is_r_and_d' => false
              }
            ]
          }
        ]
      }
    end

    it 'gets rejected' do
      expect { described_class.create_or_update_from_json(json, example_lims) }.to raise_error(CompositeResourceTools::InvalidMessage, "Contains two elements with the same composite identifier: combination of #{expected_identifiers} should be unique.")
    end
  end
end
