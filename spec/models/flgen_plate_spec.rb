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

  let(:json) do
    {
      "id_flgen_plate_lims" => "1123",
      "plate_barcode_lims" => 111,
      "plate_barcode" => 111,
      "plate_uuid_lims" => "000000-0000-0000-0000-0000000000",
      "plate_size" => "96",
      "cost_code" => "2222",
      "wells" => [
        {
          "well_label" => "S01",
          "well_uuid_lims" => "000000-0000-0000-0000-0000000000",
          "cost_code" => "cost_code1",
          "sample_uuid" => '000000-0000-0000-0000-0000000000',
          "study_uuid" => '000000-0000-0000-0000-0000000001',
          "qc_state" => 1,
          "last_updated" => "2012-03-11 10:22:42"
        },
        {
          "well_label" => "S02",
          "well_uuid_lims" => "000000-0000-0000-0000-0000000000",
          "sample_uuid" => '000000-0000-0000-0000-0000000000',
          "study_uuid" => '000000-0000-0000-0000-0000000001',
          "cost_code" => "cost_code1",
          "qc_state" => 1,
          "last_updated" => "2012-03-11 10:22:42"
        }
      ]
    }
  end
end
