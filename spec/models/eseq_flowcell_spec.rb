# frozen_string_literal: true

require 'spec_helper'

describe EseqFlowcell do
  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  shared_examples_for 'a flowcell' do
    it_behaves_like 'maps JSON fields', {
      flowcell_id: :id_flowcell_lims, position: :lane
    }

    # Eseq flowcell has fewer fields than Iseq flowcell and ignores the fields
    # that are not mapped to the columns of the eseq_flowcell table.
    it_behaves_like 'ignores JSON fields', %w[
      manual_qc
      priority
      external_release
      purpose
      spiked_phix_barcode
      spiked_phix_percentage
      workflow
      loading_concentration
      flowcell_barcode
      forward_read_length
      reverse_read_length
      tag_set_id_lims
      tag_set_name
      tag_identifier
      tag2_set_id_lims
      tag2_set_name
      tag2_identifier
      cost_code
      is_r_and_d
      tag_index
      entity_id_lims
    ]

    it_behaves_like 'belongs to', %i[study sample], { lanes: :samples }

    it_behaves_like 'a nested resource'
  end

  context 'with controls and all optional fields' do
    # We have a row for the lane, the sample and the control.
    let(:expected_entries) { 2 } # used by 'a nested resource'

    include_examples 'large eseq flowcell json'

    it_behaves_like 'a flowcell'

    context 'when non-composition fields are updated' do
      # The composition keys declared in the model are used for expanding nested
      # sections into rows. If they are not changed, we just do the update on
      # the existing records
      let(:example_lims) { 'example' }

      let(:updated_json) do
        updated_json = JSON.parse(json.to_json) # deep copy
        updated_json['lanes'].first['id_pool_lims'] = 'NT1234567U'
        updated_json['updated_at'] = '2025-03-11 12:22:42'
        updated_json
      end

      it 'reuses the existing records' do
        # create
        described_class.create_or_update_from_json(json, example_lims)
        original_ids = described_class.all.map(&:id_eseq_flowcell_tmp)
        # update
        described_class.create_or_update_from_json(updated_json, example_lims)
        new_ids = described_class.all.map(&:id_eseq_flowcell_tmp)
        expect(new_ids).to eq(original_ids)
      end
    end

    context 'when composition fields are updated' do
      # The composition keys declared in the model are used for expanding nested
      # sections into rows. If they are changed, we destroy the modified records
      # and create them again.
      let(:example_lims) { 'example' }

      let(:updated_json) do
        updated_json = JSON.parse(json.to_json) # deep copy
        updated_json['lanes'].first['samples'].first['tag_sequence'] = 'TTTT'
        updated_json['updated_at'] = '2025-03-11 12:22:42'
        updated_json
      end

      it 'destroys the existing records and creates new records' do
        # create
        described_class.create_or_update_from_json(json, example_lims)
        original_ids = described_class.all.map(&:id_eseq_flowcell_tmp)
        # destroy and create
        described_class.create_or_update_from_json(updated_json, example_lims)
        new_ids = described_class.all.map(&:id_eseq_flowcell_tmp)
        expect(new_ids).not_to eq(original_ids)
      end
    end
  end

  context 'without controls or other optional fields' do
    # We have a row for the lane, the sample
    let(:expected_entries) { 1 } # used by 'a nested resource'

    include_examples 'small eseq flowcell json'

    it_behaves_like 'a flowcell'
  end

  context 'a message with clashing samples' do
    let(:expected_identifiers) do
      'tag_index, id_flowcell_lims, entity_id_lims, entity_type, lane, ' \
        'tag_sequence, tag2_sequence'
    end
    let(:example_lims) { 'example' }

    include_examples 'small eseq flowcell json'

    let(:bad_json) do
      bad_json = JSON.parse(json.to_json) # deep copy
      bad_json['lanes'] << bad_json['lanes'].first.dup # duplicate the sample
      bad_json
    end

    it 'gets rejected' do
      expect do
        described_class.create_or_update_from_json(bad_json, example_lims)
      end.to raise_error(
        CompositeResourceTools::InvalidMessage,
        'Contains two elements with the same composite identifier: ' \
        "combination of #{expected_identifiers} should be unique."
      )
    end
  end
end
