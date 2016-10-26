class AddDataDestinationToStudiesTable < ActiveRecord::Migration
  def change
    change_table :study do |t|
      t.string   'data_destination',  comment: 'The data destination type(s) for the study. It could be \'standard\', \'14mg\' or \'gseq\'. This may be extended, if Sanger gains more external customers. It can contain multiply destinations separated by a space.'
    end
  end
end
