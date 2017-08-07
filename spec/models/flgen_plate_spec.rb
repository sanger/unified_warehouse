require 'spec_helper'

describe FlgenPlate do
  it_behaves_like 'a nested resource'

  # We have a row for the lane, the sample and the control
  let(:expected_entries) { 2 }

  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample; mock_study
  end

  it_behaves_like 'belongs to', [
    :sample,
    :study
  ], [:wells]

  include_examples 'fluidigm json'
end
