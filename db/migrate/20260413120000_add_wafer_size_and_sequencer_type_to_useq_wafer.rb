# frozen_string_literal: true

class AddWaferSizeAndSequencerTypeToUseqWafer < ActiveRecord::Migration[7.2]
  def change
    add_column :useq_wafer, :wafer_size, :string, limit: 10, comment: "Used to track UG200 wafer size only, defined in the sequencing request by SSR, default 10TB."
    add_column :useq_wafer, :requested_sequencer_type, :string, limit: 10, comment: "Requested sequencer model type, currently there is two types: UG100 & UG200"
  end
end
