# frozen_string_literal: true

# Adds the CT channel columns to the lighthouse_sample table
class AddCtColumnsToLighthouseSamples < ActiveRecord::Migration
  def change
    change_table :lighthouse_sample, bulk: true do |t|
      t.string :ch1_target, comment: 'Target for channel 1',    after: :lab_id
      t.string :ch1_result, comment: 'Result for channel 1',    after: :ch1_target
      t.float  :ch1_cq,     comment: 'Cq value for channel 1',  after: :ch1_result
      t.string :ch2_target, comment: 'Target for channel 2',    after: :ch1_cq
      t.string :ch2_result, comment: 'Result for channel 2',    after: :ch2_target
      t.float  :ch2_cq,     comment: 'Cq value for channel 2',  after: :ch2_result
      t.string :ch3_target, comment: 'Target for channel 3',    after: :ch2_cq
      t.string :ch3_result, comment: 'Result for channel 3',    after: :ch3_target
      t.float  :ch3_cq,     comment: 'Cq value for channel 3',  after: :ch3_result
      t.string :ch4_target, comment: 'Target for channel 4',    after: :ch3_cq
      t.string :ch4_result, comment: 'Result for channel 4',    after: :ch4_target
      t.float  :ch4_cq,     comment: 'Cq value for channel 4',  after: :ch4_result

      t.index :result
    end
  end
end
