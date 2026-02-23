class RemoveTagSequenceColumnLimit < ActiveRecord::Migration[7.2]
  def up
    change_column :iseq_flowcell, :tag_sequence, :string, limit: nil
    change_column :iseq_flowcell, :tag2_sequence, :string, limit: nil

    change_column :eseq_flowcell, :tag_sequence, :string, limit: nil
    change_column :eseq_flowcell, :tag2_sequence, :string, limit: nil

    change_column :useq_wafer, :tag_sequence, :string, limit: nil
  end

  def down
    change_column :iseq_flowcell, :tag_sequence, :string, limit: 30
    change_column :iseq_flowcell, :tag2_sequence, :string, limit: 30

    change_column :eseq_flowcell, :tag_sequence, :string, limit: 30
    change_column :eseq_flowcell, :tag2_sequence, :string, limit: 30

    change_column :useq_wafer, :tag_sequence, :string, limit: 30
  end
end
