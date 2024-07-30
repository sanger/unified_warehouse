class AddRetentionInstructionColumnToSampleTable < ActiveRecord::Migration[7.0]
  def change
    add_column :sample, :retention_instruction, :string
  end
end