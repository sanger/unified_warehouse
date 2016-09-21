require 'spec_helper'

describe StockResource do

  let!(:mock_sample) { create(:sample) }
  let!(:mock_study)  { create(:study)  }

  before(:each) do
    mock_sample; mock_study
  end

  shared_examples_for 'a stock material' do

    it_behaves_like 'maps JSON fields', {
    }

    it_behaves_like 'ignores JSON fields', [
    ]

    it_behaves_like 'belongs to', [
      [:study,:sample]
    ]

    it_behaves_like 'a singular resource'
  end

  context 'for a well' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 1 }

    it_behaves_like 'a stock material'

    let(:json) do
      {
        "created_at" => "2012-03-11 10:22:42",
        "updated_at" => "2012-03-11 10:22:42",

        "sample_uuid" => "000000-0000-0000-0000-0000000000",
        "study_uuid" => "000000-0000-0000-0000-0000000001",

        "stock_resource_id" => "12345",
        "stock_resource_uuid" => "000000-0000-0000-0000-0000000002",

        # We don't validate the barcode format, other
        # LIMS might use different standards
        "labware_machine_barcode" => "1220456987123",
        "labware_human_barcode" => "DN456987D",
        "labware_coordinate" => "A1",
        "labware_type" => "well",

        "current_volume" => 1.23,
        "initial_volume" => 4.56,
        "concentration"  => 23.56,

        "gel_pass" => "Pass",
        "pico_pass" => "Pass",
        "snp_count" => 2,
        "measured_gender" => "Unknown"

      }
    end

  end

  context 'for a well with SS formatted data' do
    # We have a row for the lane, the sample and the control
    let(:expected_entries) { 1 }

    it_behaves_like 'a stock material'

    let(:json) do
      {
        "created_at" => "2012-03-11T10:22:42+00:00",
        "updated_at" => "2012-03-11T10:22:42+00:00",

        "sample_uuid" => "000000-0000-0000-0000-0000000000",
        "study_uuid" => "000000-0000-0000-0000-0000000001",

        "stock_resource_id" => 12345,
        "stock_resource_uuid" => "000000-0000-0000-0000-0000000002",

        # We don't validate the barcode format, other
        # LIMS might use different standards
        "labware_machine_barcode" => "1220456987123",
        "labware_human_barcode" => "DN456987D",
        "labware_coordinate" => "A1",
        "labware_type" => "well",

        "current_volume" => 1.23,
        "initial_volume" => 4.56,
        "concentration"  => 23.56,

        "gel_pass" => "Pass",
        "pico_pass" => "Pass",
        "snp_count" => 2,
        "measured_gender" => "Unknown"

      }
    end

  end


  context 'for a tube' do

    let(:expected_entries) { 1 }

    let(:json) do
      {
        "created_at" => "2012-03-11 10:22:42",
        "updated_at" => "2012-03-11 10:22:42",

        "sample_uuid" => "000000-0000-0000-0000-0000000000",
        "study_uuid" => "000000-0000-0000-0000-0000000001",

        "stock_resource_id" => "12345",
        "stock_resource_uuid" => "000000-0000-0000-0000-0000000002",

        # We don't validate the barcode format, other
        # LIMS might use different standards
        "machine_barcode" => "3040456987123",
        "human_barcode" => "NT456987D",
        "labware_type" => "tube"

        # QC data will not always be present, especially for tubes
        # So lets make sure its absence doesn't cause issues

      }
    end

  end

end
