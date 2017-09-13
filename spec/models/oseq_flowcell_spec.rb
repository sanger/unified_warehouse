require 'spec_helper'

describe OseqFlowcell do
  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample
    mock_study
  end

  it_behaves_like 'a singular resource'

  it_behaves_like 'maps JSON fields', flowcell_id: :id_flowcell_lims

  it_behaves_like 'belongs to', %i[study sample], nil

  let(:json) do
    {
      id_flowcell_lims: 1,
      updated_at: '2017-08-25T09:30:28.133Z',
      sample_uuid: mock_sample.uuid_sample_lims,
      study_uuid: mock_study.uuid_study_lims,
      experiment_name: 1,
      instrument_name: 'Instrument',
      instrument_slot: 5,
      pipeline_id_lims: 'Rapid',
      requested_data_type: 'basecalls'
    }
  end
end
