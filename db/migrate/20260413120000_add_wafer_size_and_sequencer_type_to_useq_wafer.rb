# frozen_string_literal: true

class AddWaferSizeAndSequencerTypeToUseqWafer < ActiveRecord::Migration[7.2]
  def change
    add_column :useq_wafer, :wafer_size, :string, limit: 30, comment: "Wafer size"
    add_column :useq_wafer, :sequencer_type, :string, limit: 30, comment: "Sequencer type"
  end
end
