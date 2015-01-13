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

end
