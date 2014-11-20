class IncreaseSizeOfIdPipelineLims < ActiveRecord::Migration
  def up
    change_table :iseq_flowcell do |t|
      t.change "pipeline_id_lims",     :string,  limit: 60, null: true, comment: "LIMs-specific pipeline identifier that unambiguously defines library type"
    end
  end

  def down
    change_table :iseq_flowcell do |t|
      t.change  "pipeline_id_lims",     :string,  limit: 60, null: true, comment: "LIMs-specific pipeline identifier that unambiguously defines library type"
    end
  end
end
