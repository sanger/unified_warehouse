# frozen_string_literal: true

require 'spec_helper'
require 'rake'
Rails.application.load_tasks if Rake::Task.tasks.empty?
RSpec.describe 'psd_sample_compounds_components:link_kinnex_compound_samples', type: :task do
  let(:compound_sample_id) { 12 }
  let(:component_sample_id1) { 10 }
  let(:component_sample_id2) { 11 }

  let!(:compound_sample1) do
    Sample.create!(id_sample_lims: 1, name: 'SP09a', id_lims: 'Traction',
                   uuid_sample_lims: 123_456, last_updated: '2012-03-11 10:22:42')
  end
  let!(:compound_sample2) do
    Sample.create!(id_sample_lims: 4, name: 'SP11b', id_lims: 'Traction',
                   uuid_sample_lims: 123_459, last_updated: '2012-03-11 10:22:42')
  end
  let!(:component_samples) do
    [Sample.create!(id_sample_lims: 5, supplier_name: 'SP11b', uuid_sample_lims: 123_460,
                    last_updated: '2012-03-11 10:22:42', id_lims: 'SQSCP', accession_number: 'ACC125'),
     Sample.create!(id_sample_lims: 6, supplier_name: 'SP11b', uuid_sample_lims: 123_461,
                    last_updated: '2012-03-11 10:22:42', id_lims: 'SQSCP', accession_number: 'ACC126'),

     Sample.create!(id_sample_lims: 2, supplier_name: 'SP09a', uuid_sample_lims: 123_457,
                    last_updated: '2012-03-11 10:22:42', id_lims: 'SQSCP', accession_number: 'ACC123'),
     Sample.create!(id_sample_lims: 3, supplier_name: 'SP09a', uuid_sample_lims: 123_458,
                    last_updated: '2012-03-11 10:22:42', id_lims: 'SQSCP', accession_number: 'ACC124')]
  end

  context 'linking compound samples' do
    describe 'component samples with a consistent supplier_name' do
      before do
        Rake::Task['psd_sample_compounds_components:link_kinnex_compound_samples'].reenable
      end

      it 'set compound sample to the same supplier name' do
        expect do
          Rake::Task['psd_sample_compounds_components:link_kinnex_compound_samples'].invoke
        end.to change(SampleCompoundComponent, :count).by(4)

        records = SampleCompoundComponent.all

        # Check mapping for SP09a
        sp09a_components_ids = component_samples.select { |s| s.supplier_name == 'SP09a' }.map(&:id)
        sp09a_components_ids.each do |component_id|
          record = records.find { |r| r.component_id_sample_tmp == component_id }
          expect(record.compound_id_sample_tmp).to eq(compound_sample1.id)
        end

        # Check mapping for SP11b
        sp11b_components_ids = component_samples.select { |s| s.supplier_name == 'SP11b' }.map(&:id)
        sp11b_components_ids.each do |component_id|
          record = records.find { |r| r.component_id_sample_tmp == component_id }
          expect(record.compound_id_sample_tmp).to eq(compound_sample2.id)
        end
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
