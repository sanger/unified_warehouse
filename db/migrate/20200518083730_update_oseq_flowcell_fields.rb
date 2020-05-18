class UpdateOseqFlowcellFields < ActiveRecord::Migration
  def change
    change_column :oseq_flowcell,
                  :pipeline_id_lims,
                  :string,
                  null: true,
                  comment: 'LIMs-specific pipeline identifier that unambiguously defines ' \
                           'library type'

    change_column :oseq_flowcell,
                  :requested_data_type,
                  :string,
                  null: true,
                  comment: 'The type of data produced by sequencing, eg. basecalls only'
  end
end
