# frozen_string_literal: true

# Foreign  key constraints are good, as they help preserve data integrity, and also
# act as self documentation.
class AddForeignKeyConstraintToSampleExtationActivtyTable < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :samples_extraction_activity, :sample, column: :id_sample_tmp, primary_key: :id_sample_tmp
  end
end
