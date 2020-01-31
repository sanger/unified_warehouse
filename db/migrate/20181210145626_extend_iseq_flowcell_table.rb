# frozen_string_literal: true

class ExtendIseqFlowcellTable < ActiveRecord::Migration
  def change
    # rubocop:disable Layout/ExtraSpacing
    change_table :iseq_flowcell, bulk: true do |t|
      t.string :spiked_phix_barcode, limit: 20, comment: 'Barcode of the PhiX tube added to the lane'
      t.float  :spiked_phix_percentage,         comment: 'Percentage PhiX tube spiked in the pool in terms of molar concentration'
      t.float  :loading_concentration,          comment: 'Final instrument loading concentration (pM)'
      t.float  :workflow,            limit: 20, comment: 'Workflow used when processing the flowcell'
    end
    # rubocop:enable Layout/ExtraSpacing
  end
end
