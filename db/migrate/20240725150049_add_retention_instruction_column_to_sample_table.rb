class AddRetentionInstructionColumnToSampleTable < ActiveRecord::Migration[7.0]
  def up
    add_column :sample, :retention_instruction, :string
  end

  def down
    remove_column :sample, :retention_instruction
  end
end
