class AddDataReleaseTimingPublicationRelevantFieldsToStudy < ActiveRecord::Migration[7.2]
  def change
    add_column :study, :data_release_timing_publication_comment, :string, default: nil
    add_column :study, :data_share_in_preprint, :string, default: nil
  end
end
