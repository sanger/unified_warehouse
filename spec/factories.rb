FactoryGirl.define do
  factory :sample do
    uuid_sample_lims '000000-0000-0000-0000-0000000000'
    id_lims 'example'
    id_sample_lims '12345'
    last_updated '2012-03-11 10:22:42'
  end

  factory :study do
    uuid_study_lims '000000-0000-0000-0000-0000000001'
    id_lims 'example'
    id_study_lims '12345'
    last_updated '2012-03-11 10:22:42'
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
    date_tested Time.new(2020, 4, 1, 1, 0, 0, '+00:00')
    source 'Test Centre'
    lab_id 'TC'
    ch1_target 'ORF1ab'
    ch1_result 'Positive'
    ch1_cq 12.46979445
    ch2_target 'N gene'
    ch2_result 'Positive'
    ch2_cq 13.2452244
    ch3_target 'S gene'
    ch3_result 'Positive'
    ch3_cq 13.07034452
    ch4_target 'MS2'
    ch4_result 'Positive'
    ch4_cq 24.98589115
    created_at Time.new(2020, 4, 2, 1, 0, 0, '+00:00')
    updated_at Time.new(2020, 4, 2, 1, 0, 0, '+00:00')
  end
end
