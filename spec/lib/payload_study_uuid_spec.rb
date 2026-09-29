# frozen_string_literal: true

require 'spec_helper'
require './lib/payload'
require './app/models/study'

RSpec.describe 'Study uuid duplication via the consumer', type: :lib do
  let(:shared_uuid) { '11111111-2222-3333-4444-555555555555' }

  def study_message(id_lims:, id_study_lims:)
    {
      'study' => {
        'uuid' => shared_uuid,
        'id' => id_study_lims,
        'name' => 'Shared study',
        'updated_at' => Time.zone.now.to_s
      },
      'lims' => id_lims
    }.to_json
  end

  it 'creates two distinct study records for the same uuid from different LIMS' do
    Payload.from_json(study_message(id_lims: 'SQSCP', id_study_lims: '1234')).record
    Payload.from_json(study_message(id_lims: 'SAPIO', id_study_lims: '5678')).record

    records = Study.where(uuid_study_lims: shared_uuid)
    expect(records.count).to eq(2)
    expect(records.pluck(:id_lims)).to contain_exactly('SQSCP', 'SAPIO')
  end

  it 'still updates in place when the same id_lims/id_study_lims is sent again' do
    Payload.from_json(study_message(id_lims: 'SQSCP', id_study_lims: '1234')).record
    Payload.from_json(study_message(id_lims: 'SQSCP', id_study_lims: '1234')).record

    expect(Study.where(uuid_study_lims: shared_uuid, id_lims: 'SQSCP').count).to eq(1)
  end
end
