# frozen_string_literal: true

require 'spec_helper'
require 'rake'
# only load Rake tasks if they haven't been loaded already
Rails.application.load_tasks if Rake::Task.tasks.empty?

RSpec.describe 'RakeTasks' do
  describe 'sample_table:update_id_sample_lims' do
    let!(:traction_sample) { create(:sample, id_lims: 'Traction', name: 'SampleName1', id_sample_lims: 'OldValue1', uuid_sample_lims: SecureRandom.uuid) }
    let!(:non_traction_sample) { create(:sample, id_lims: 'Other', name: 'SampleName2', id_sample_lims: 'OldValue2', uuid_sample_lims: SecureRandom.uuid) }
    let!(:existing_sample) { create(:sample, id_lims: 'Traction', name: 'SampleName1', id_sample_lims: 'OldValue2', uuid_sample_lims: SecureRandom.uuid) }

    before do
      Rake::Task['sample_table:update_id_sample_lims'].reenable
    end

    it 'updates id_sample_lims to the value of the name column for traction samples' do
      expect { Rake::Task['sample_table:update_id_sample_lims'].invoke }.to change { traction_sample.reload.id_sample_lims }.from('OldValue1').to('SampleName1').and output(
        /Updating id_sample_lims for sample #{traction_sample.id} to SampleName1/
      ).to_stdout
    end

    it 'does not change id_sample_lims for non-traction samples' do
      expect { Rake::Task['sample_table:update_id_sample_lims'].invoke }.not_to(change { non_traction_sample.reload.id_sample_lims })
    end

    it 'does not change id_sample_lims if the name is already in id_sample_lims' do
      expect { Rake::Task['sample_table:update_id_sample_lims'].invoke }.not_to(change { existing_sample.reload.id_sample_lims })
    end
    it 'raises an error if saving the sample fails' do
      allow_any_instance_of(Sample).to receive(:save!).and_raise(ActiveRecord::ActiveRecordError, 'Simulated save error')

      expect do
        Rake::Task['sample_table:update_id_sample_lims'].invoke
      end.to output(/Failed to update id_sample_lims for sample #{traction_sample.id}: Simulated save error/).to_stdout
    end
  end
end
