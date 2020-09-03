FactoryGirl.define do
  factory :sample do
    uuid_sample_lims "000000-0000-0000-0000-0000000000"
    id_lims "example"
    id_sample_lims "12345"
    last_updated "2012-03-11 10:22:42"
  end

  factory :study do
    uuid_study_lims "000000-0000-0000-0000-0000000001"
    id_lims "example"
    id_study_lims "12345"
    last_updated "2012-03-11 10:22:42"
  end

  factory :lighthouse_sample do
    mongodb_id '5f3a91045019939dc1ac317b'
    root_sample_id 'ABC00000001'
    cog_uk_id 'PREFIX-12AB34'
    rna_id 'PR-rna-00000001_H12'
    plate_barcode 'PR-rna-00000001'
    coordinate 'H12'
    result 'Negative'
    date_tested_string '2020-04-01 010000 UTC'
    date_tested DateTime.new(2020, 04, 01, 1, 0, 0)
    source 'Test Centre'
    lab_id 'TC'
    created_at_external DateTime.new(2020, 04, 02, 1, 0, 0)
    updated_at_external DateTime.new(2020, 04, 02, 1, 0, 0)
    created_at DateTime.new(2020, 04, 02, 1, 0, 0)
    updated_at DateTime.new(2020, 04, 02, 1, 0, 0)
  end
end
