# frozen_string_literal: true

require 'spec_helper'
require 'rake'
Rails.application.load_tasks if Rake::Task.tasks.empty?
RSpec.describe 'psd_sample_compounds_components:link_kinnex_compound_samples', type: :task do
  # before do
  #   Rake.application.rake_require 'tasks/link_kinnex_compound_samples'
  #   Rake::Task.define_task(:environment)
  # end

  let(:compound_sample_id) { 12 }
  let(:component_sample_id1) { 10 }
  let(:component_sample_id2) { 11 }

  let!(:samples) do
    [
      Sample.create!(id_sample_lims: compound_sample_id, name: 'SP09a', id_lims: 'Traction',
                     uuid_sample_lims: 123_456, last_updated: '2012-03-11 10:22:42'),
      Sample.create!(id_sample_lims: component_sample_id1, supplier_name: 'SP09a', uuid_sample_lims: 123_457,
                     last_updated: '2012-03-11 10:22:42', id_lims: 'SQSCP', accession_number: 'ACC123'),
      Sample.create!(id_sample_lims: component_sample_id2, supplier_name: 'SP09a', uuid_sample_lims: 123_458,
                     last_updated: '2012-03-11 10:22:42', id_lims: 'SQSCP', accession_number: 'ACC124')
    ]
  end

  context 'linking compound samples' do
    describe 'component samples with a consistent supplier_name' do
      before do
        Rake::Task['psd_sample_compounds_components:link_kinnex_compound_samples'].reenable
      end

      it 'set compound sample to the same supplier name' do
        expect do
          Rake::Task['psd_sample_compounds_components:link_kinnex_compound_samples'].invoke
        end.to change(SampleCompoundComponent, :count).by(2)
      end
    end

    describe 're-running the task should not import further changes to SampleCompoundComponent table' do
      before do
        Rake::Task['psd_sample_compounds_components:link_kinnex_compound_samples'].reenable
      end

      it 'does not update psd_sample_compounds_components' do
        expect { Rake::Task['psd_sample_compounds_components:link_kinnex_compound_samples'].invoke }.not_to(change { SampleCompoundComponent })
      end
    end
  end
end
