class AddTagSequenceToPsdSampleCompoundsComponents < ActiveRecord::Migration[8.1]
  def change
    add_column :psd_sample_compounds_components, :tag_sequence, :string,
               comment: 'The tag sequence of the component sample within the compound sample,  ' \
                        'e.g. for Kinnex. Null when the components are not tagged.'
  end
end
