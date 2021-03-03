# frozen_string_literal: true

# Adds the CT channel columns to the lighthouse_sample table
class AddCtColumnsToLighthouseSamples < ActiveRecord::Migration[4.2]
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.string  :ch1_target, null: true, comment: 'Target for channel 1', after: :lab_id
      t.string  :ch1_result, null: true, comment: 'Result for channel 1', after: :ch1_target
      t.decimal :ch1_cq, precision: 11, scale: 8, null: true, comment: 'Cq value for channel 1', after: :ch1_result
      t.string  :ch2_target, null: true, comment: 'Target for channel 2', after: :ch1_cq
      t.string  :ch2_result, null: true, comment: 'Result for channel 2', after: :ch2_target
      t.decimal :ch2_cq, precision: 11, scale: 8, null: true, comment: 'Cq value for channel 2', after: :ch2_result
      t.string  :ch3_target, null: true, comment: 'Target for channel 3', after: :ch2_cq
      t.string  :ch3_result, null: true, comment: 'Result for channel 3', after: :ch3_target
      t.decimal :ch3_cq, precision: 11, scale: 8, null: true, comment: 'Cq value for channel 3', after: :ch3_result
      t.string  :ch4_target, null: true, comment: 'Target for channel 4', after: :ch3_cq
      t.string  :ch4_result, null: true, comment: 'Result for channel 4', after: :ch4_target
      t.decimal :ch4_cq, precision: 11, scale: 8, null: true, comment: 'Cq value for channel 4', after: :ch4_result
    end
  end
end
