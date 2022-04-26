# frozen_string_literal: true

# Changes the comment on the manual qc field in the iseq_flowcell table to avoid confusion for users
class UpdateManualQcDescriptionOnISeqFlowcell < ActiveRecord::Migration[6.0]
  def up
    change_column :iseq_flowcell, :manual_qc, :boolean, comment: 'Legacy QC decision value set per lane which may be used for per-lane billing: iseq_product_metrics.qc is likely to contain the per product QC summary of use to most downstream users'
  end

  def down
    change_column :iseq_flowcell, :manual_qc, :boolean, comment: 'Manual QC decision, NULL for unknown'
  end
end
