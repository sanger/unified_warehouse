# frozen_string_literal: true

# Add control_type column, to store whether a control is positive or negative
# Added for the Heron project
# Works in conjunction with control column
class AddControlTypeToSample < ActiveRecord::Migration
  def change
    add_column :sample, :control_type, :string
  end
end
