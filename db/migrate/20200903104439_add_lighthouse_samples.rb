class AddLighthouseSamples < ActiveRecord::Migration
  def change
    create_table :lighthouse_samples do |t|
      t.string :lims_id
      t.string :root_sample_id
      t.string :cog_uk_id
      t.string :rna_id
      t.string :plate_barcode
      t.string :coordinate
      t.string :result
      t.string :date_tested
      t.string :source
      t.string :lab_id

      t.timestamps
    end
  end
end

# MongoDB record
# {
#   "_id" : ObjectId("5f3a91045019939dc1ac317b"),
#   "Lab ID" : "AP",
#   "RNA ID" : "AP-rna-00110029_F11",
#   "Date Tested" : "2020-04-23 14:40:08 UTC",
#   "RNA-PCR ID" : "CF06CR9S_F11",
#   "Viral Prep ID" : "AP-kfr-00070085_F11",
#   "Root Sample ID" : "GNM00015904",
#   "Result" : "Negative",
#   "source" : "Alderley",
#   "plate_barcode" : "AP-rna-00110029",
#   "coordinate" : "F11",
#   "line_number" : 24,
#   "file_name" : "AP_sanger_report_200423_2214.csv",
#   "file_name_date" : ISODate("2020-04-23T22:14:00Z"),
#   "created_at" : ISODate("2020-05-07T12:51:00Z"),
#   "updated_at" : ISODate("2020-08-17T15:15:32.048Z"),
#   "concat_id" : "GNM00015904 - AP-rna-00110029_F11 - Negative",
#   "migrated_temp" : "Yes"
# }