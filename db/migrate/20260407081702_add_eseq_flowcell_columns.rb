# frozen_string_literal: true

class AddEseqFlowcellColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :eseq_flowcell, :quant_method_used, :string, limit: 50, comment: 'Quantification method used for the run'
    add_column :eseq_flowcell, :custom_primer_kit_used, :string, limit: 10, comment: 'Has a custom primer kit been used for the run: Yes, No'
  end
end
