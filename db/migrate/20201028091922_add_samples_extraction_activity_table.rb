# frozen_string_literal: true

# Creates a table for tracking samples extraction lims activities
class AddSamplesExtractionActivityTable < ActiveRecord::Migration[4.2]
  def change
    create_table :samples_extraction_activity, primary_key: :id_activity_tmp, options: 'CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
      t.string :id_activity_lims, null: false, comment: 'LIMs-specific activity id', index: true

      t.column :id_sample_tmp, 'integer unsigned', null: false, comment: 'Sample id, see "sample.id_sample_tmp"'

      t.string :activity_type, null: false, comment: 'The type of the activity performed'
      t.string :instrument, null: false, comment: 'The name of the instrument used to perform the activity'
      t.string :kit_barcode, null: false, comment: 'The barcode of the kit used to perform the activity'
      t.string :kit_type, null: false, comment: 'The type of kit used to perform the activity'
      t.string :input_barcode, null: false, comment: 'The barcode of the labware (eg. plate or tube) at the begining of the activity'
      t.string :output_barcode, null: false, comment: 'The barcode of the labware (eg. plate or tube)  at the end of the activity'
      t.string :user, null: false, comment: 'The name of the user who was most recently associated with the activity'

      t.datetime :last_updated, null: false, comment: 'Timestamp of last change to activity'
      t.datetime :recorded_at, null: false, comment: 'Timestamp of warehouse update'
      t.datetime :completed_at, null: false, comment: 'Timestamp of activity completion'
      t.datetime :deleted_at, null: true, comment: 'Timestamp of any activity removal'

      t.string :id_lims, limit: 10, null: false, comment: 'LIM system identifier'
    end
  end
end
