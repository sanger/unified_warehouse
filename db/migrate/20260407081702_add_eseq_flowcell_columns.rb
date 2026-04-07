# frozen_string_literal: true

class AddEseqFlowcellColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :eseq_flowcell, :quant_method_used, :string, limit: 255, comment: 'Quantification method used for the run'
    add_column :eseq_flowcell, :custom_primer_kit_used, :string, limit: 255, comment: 'Custom primer kit used for the run, values: Yes, No'
  end
end
