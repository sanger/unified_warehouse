class UpdateCommentsOnUseqWaferColumn < ActiveRecord::Migration[7.2]
  def change
    change_column_comment :useq_wafer, :wafer_size, "Used to track UG 200 wafer size only, defined in the sequencing request by SSR"
    change_column_comment :useq_wafer, :requested_sequencer_type, "Requested sequencer model, 'UG 100' or 'UG 200'"
  end
end
