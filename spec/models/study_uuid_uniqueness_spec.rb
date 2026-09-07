# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Study, type: :model do
  describe 'uuid_study_lims uniqueness' do
    let(:shared_uuid) { '11111111-2222-3333-4444-555555555555' }
    let(:common_attributes) do
      {
        uuid_study_lims: shared_uuid,
        last_updated: Time.zone.now,
        recorded_at: Time.zone.now,
        name: 'Shared study'
      }
    end

    let!(:sequencescape_study) do
      Study.create!(common_attributes.merge(id_lims: 'SQSCP', id_study_lims: '1234'))
    end

    it 'allows a second record with the same uuid but a different id_lims/id_study_lims' do
      expect do
        Study.create!(common_attributes.merge(id_lims: 'SAPIO', id_study_lims: '5678'))
      end.not_to raise_error
    end

    it 'results in two distinct records sharing the same uuid_study_lims' do
      Study.create!(common_attributes.merge(id_lims: 'SAPIO', id_study_lims: '5678'))
      expect(Study.where(uuid_study_lims: shared_uuid).count).to eq(2)
    end

    it 'still enforces uniqueness on the (id_lims, id_study_lims) pair' do
      expect do
        Study.create!(common_attributes.merge(id_lims: 'SQSCP', id_study_lims: '1234'))
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
