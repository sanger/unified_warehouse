class AddDevelopmentalStageToSample < ActiveRecord::Migration
  def change
    add_column :sample, :developmental_stage, :string, comment: 'Developmental Stage'
  end
end
