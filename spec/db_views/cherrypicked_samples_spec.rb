# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'cherrypicked_samples_view', :integration do
  # @note We use before_type_cast in a few places here, as the raw view SQL query doesn't cast its values.
  # This is a little useful for testing the uuids (although oddly we need to reload to get the correct behaviour)
  # but as the actual interface will be with the SQL directly, we don't actually care about the details of what
  # comes back from
  let(:sample_1_id) { 1 }
  let(:sample_2_id) { 2 }
  let(:study) { create :study }
  let!(:beckman_sample1) do
    create(:sample, id_sample_tmp: sample_1_id, sanger_sample_id: 'MY_SANGER_SAMPLE_ID_1',
                    uuid_sample_lims: '00000000-1111-2222-3333-888888888888')
  end
  let!(:lh_sample1) { create(:lighthouse_sample, lh_sample_uuid: beckman_sample1.uuid_sample_lims) }
  let!(:tecan_sample2) do
    create(:sample, id_sample_tmp: sample_2_id, sanger_sample_id: 'MY_SANGER_SAMPLE_ID_2',
                    uuid_sample_lims: '00000000-1111-2222-3333-999999999999')
  end
  let!(:stock_resource_sample2) do
    create(:stock_resource, id_sample_tmp: sample_2_id,
                            stock_resource_uuid: tecan_sample2.uuid_sample_lims, id_study_tmp: study.id)
  end
  let(:results) do
    ApplicationRecord.connection.execute('SELECT * FROM cherrypicked_samples')
  end

  it 'lists finished activities at the role level' do
    expect(results.size).to eq 2
  end

  it 'has the expected columns' do
    expect(results.fields).to eq %w[
      root_sample_id plate_barcode phenotype coordinate created robot_type
    ]
  end
end
