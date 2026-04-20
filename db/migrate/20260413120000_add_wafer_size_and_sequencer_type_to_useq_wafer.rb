# frozen_string_literal: true

class AddWaferSizeAndSequencerTypeToUseqWafer < ActiveRecord::Migration[7.2]
  def change
    add_column :useq_wafer, :wafer_size, :string, limit: 10, comment: "Wafer size, e.g. 10TB"
    add_column :useq_wafer, :sequencer_type, :string, limit: 10, comment: "Sequencer type, e.g UG200"
  end
end
