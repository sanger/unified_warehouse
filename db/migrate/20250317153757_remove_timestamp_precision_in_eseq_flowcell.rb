# frozen_string_literal: true

# The default timestamp precision has changed between MySQL versions. This
# migration removes the subsecond precision from the timestamps in the
# eseq_flowcell table to make it similar to the iseq_flowcell table.
# Explicit up and down are added to enable rollback with change_column.
class RemoveTimestampPrecisionInEseqFlowcell < ActiveRecord::Migration[7.1]
  def up
    change_column :eseq_flowcell, :last_updated, :datetime, precision: 0
    change_column :eseq_flowcell, :recorded_at, :datetime, precision: 0
  end
  def down
    change_column :eseq_flowcell, :last_updated, :datetime
    change_column :eseq_flowcell, :recorded_at, :datetime
  end
end
