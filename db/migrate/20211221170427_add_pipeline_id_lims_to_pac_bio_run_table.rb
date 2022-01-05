# frozen_string_literal: true

# A column equivalent to library_type in the iseq flowcell tables is being added to pacbio
class AddPipelineIdLimsToPacBioRunTable < ActiveRecord::Migration[6.0]
  def change
    change_table :pac_bio_run, bulk: true do |t|
      t.string :pipeline_id_lims, null: true, default: nil, limit: 60, comment: 'LIMS-specific pipeline identifier that unambiguously defines library type (eg. Sequel-v1, IsoSeq-v1)'
    end
  end
end
