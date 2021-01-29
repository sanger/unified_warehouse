BECKMAN_RECORD = {
  "event":{
    "uuid": "00000000-1111-2222-3333-444444444444",
    "event_type": "lh_beckman_cp_destination_created",
    "occured_at": "2020-03-11 10:22:42",
    "user_identifier": "postmaster@example.com",
    "subjects":[
      {
        "role_type": "source",
        "subject_type": "sample",
        "friendly_name": "MY_SANGER_SAMPLE_ID_1",
        "uuid": sample_uuid_1
      }
    ],
    "metadata":{
    }
  },
  "lims": "example"
}

CHERRYPICK_RECORD={
  "event":{
    "uuid": "00000000-1111-2222-3333-444444444444",
    "event_type": "cherrypick_layout_set",
    "occured_at": "2020-03-11 10:22:42",
    "user_identifier": "postmaster@example.com",
    "subjects":[
      {
        "role_type": "source",
        "subject_type": "sample",
        "friendly_name": "MY_SANGER_SAMPLE_ID_2",
        "uuid": sample_uuid_2
      }
    ],
    "metadata":{
    }
  },
  "lims": "example"
}

OTHER_RECORD = {
  "event":{
    "uuid": "00000000-1111-2222-3333-444444444444",
    "event_type": "delivery",
    "occured_at": "2012-03-11 10:22:42",
    "user_identifier": "postmaster@example.com",
    "subjects":[
      {
        "role_type": "sender",
        "subject_type": "person",
        "friendly_name": "alice@example.com",
        "uuid": "00000000-1111-2222-3333-555555555555"
      },
      {
        "role_type": "recipient",
        "subject_type": "person",
        "friendly_name": "bob@example.com",
        "uuid": "00000000-1111-2222-3333-666666666666"
      },
      {
        "role_type": "package",
        "subject_type": "plant",
        "friendly_name": "Chuck",
        "uuid": "00000000-1111-2222-3333-777777777777"
      }
    ],
    "metadata":{
      "delivery_method": "courier",
      "shipping_cost": "15.00"
    }
  },
  "lims": "example"
}

EVENTS = [BECKMAN_RECORD, CHERRYPICK_RECORD, OTHER_RECORD]

EVENTS.each do |data|
  Event.create_or_update_from_json(data[:event], data[:lims])
end