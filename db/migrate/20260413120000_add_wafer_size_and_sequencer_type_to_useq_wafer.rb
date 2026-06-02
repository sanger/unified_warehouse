# frozen_string_literal: true

class AddWaferSizeAndSequencerTypeToUseqWafer < ActiveRecord::Migration[7.2]
  def change
    add_column :useq_wafer, :wafer_size, :string, limit: 10, comment: "Used to track UG200 wafer size only, defined in the sequencing request by SSR."
    add_column :useq_wafer, :requested_sequencer_type, :string, limit: 10, comment: "Requested sequencer model, 'UG 100' & 'UG 200'"
  end
end
