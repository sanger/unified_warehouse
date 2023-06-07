# frozen_string_literal: true

#
# Add a column to allow COG UK IDs to be unique but ensure they otherwise are not NULL
# and are unique going forward.
class AddCogUkIdUniqueColumnToLighthouseSample < ActiveRecord::Migration[7.0]
  def self.up
    change_column_null :lighthouse_sample, :cog_uk_id, false
    add_column :lighthouse_sample, :cog_uk_id_unique, :tinyint, default: 1, after: :cog_uk_id, comment: 'A flag to indicate cog_uk_id should be unique. NULL allows reuse of the ID in another row.'
    remove_index :lighthouse_sample, :cog_uk_id  # Remove the unique constraint index
    add_index :lighthouse_sample, :cog_uk_id
    add_index :lighthouse_sample, %i[cog_uk_id cog_uk_id_unique], unique: true
  end

  def self.down
    remove_index :lighthouse_sample, %i[cog_uk_id cog_uk_id_unique]
    remove_index :lighthouse_sample, :cog_uk_id  # Remove the non-unique constraint index
    add_index :lighthouse_sample, :cog_uk_id, unique: true
    remove_column :lighthouse_sample, :cog_uk_id_unique
    change_column_null :lighthouse_sample, :cog_uk_id, true
  end
end
