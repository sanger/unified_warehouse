# frozen_string_literal: true

require 'spec_helper'

describe Sample do
  shared_examples 'a sample resource' do
    it_behaves_like 'a singular resource'
    it_behaves_like 'maps JSON fields', {
      id: :id_sample_lims,
      uuid: :uuid_sample_lims,
      updated_at: :last_updated
    }

    it_behaves_like 'ignores JSON fields', %i[
      new_name_format
      sample_manifest_id
      sample_tubes
    ]
  end

  context 'with uuid' do
    include_examples 'sample json'
    it_behaves_like 'a sample resource'
  end

  context 'without uuid' do
    it_behaves_like 'a sample resource'

    let(:json) do
      {
        'id' => 1,
        'name' => 'name',
        'reference_genome' => 'reference genome',
        'organism' => 'organism',
        'consent_withdrawn' => true,
        'accession_number' => 'accession number',
        'common_name' => 'common name',
        'description' => 'description',
        'taxon_id' => 'taxon id',
        'father' => 'father',
        'mother' => 'mother',
        'replicate' => 'replicate',
        'ethnicity' => 'ethnicity',
        'gender' => 'gender',
        'cohort' => 'cohort',
        'country_of_origin' => 'country of origin',
        'geographical_region' => 'geographical region',
        'updated_at' => '2012-03-11 10:22:42',
        'created_at' => '2012-03-11 10:22:42',
        'sanger_sample_id' => 'sanger sample id',
        'control' => true,
        'empty_supplier_sample_name' => true,
        'supplier_name' => 'supplier name',
        'public_name' => 'public name',
        'sample_visibility' => 'sample visibility',
        'strain' => 'strain',
        'updated_by_manifest' => true,
        'donor_id' => '11111111-2222-3333-4444-555555555556',
        'developmental_stage' => 'Larval: Day 5 ZFS:0000037',
        'control_type' => 'positive'
      }
    end
  end

  context 'compound samples via JSON' do
    let(:example_lims) { 'example' }
    let(:component_sample) { create(:sample, uuid_sample_lims: '012345-6789-UUID-0002') }
    let(:json) do
      {
        updated_at: '2012-03-11 10:22:42',
        created_at: '2012-03-11 10:22:42',
        uuid: '012345-6789-UUID-0001',
        id: 12345,
        name: 'compound_sample',
        component_sample_uuids: [{ 'uuid': component_sample[:uuid_sample_lims] }]
      }
    end

    it 'sets up the association between compound and component sample' do
      described_class.create_or_update_from_json(json, example_lims)

      expect(Sample.count).to be 2
      expect(SampleCompoundComponent.count).to be 1

      compound_sample = Sample.find_by(name: 'compound_sample')
      expect(compound_sample.component_samples).to match_array [component_sample]
      expect(component_sample.compound_samples).to match_array [compound_sample]
    end

    it 'raises ActiveRecord::RecordNotFound when the component sample UUID cannot be found' do
      modified_json = json.merge({ component_sample_uuids: [{ 'uuid': 'MADE_UP_UUID' }] })

      expect do
        described_class.create_or_update_from_json(modified_json, example_lims)
      end.to raise_error ActiveRecord::RecordNotFound, "No sample with uuid 'MADE_UP_UUID'"
    end


  context 'compound samples directly in Rails' do
    let!(:compound_sample) { create(:sample, uuid_sample_lims: '012345-6789-UUID-0001') }
    let!(:component_sample) { create(:sample, uuid_sample_lims: '012345-6789-UUID-0002') }

    before(:each) do
      # let variables are lazily loaded, so set up the association here otherwise
      # the association will change during tests depending on which variables you
      # access first.
      compound_sample.component_samples = [component_sample]
      compound_sample.reload
      component_sample.reload
    end

    it 'makes the association between samples' do
      expect(compound_sample.component_samples).to match_array [component_sample]
      expect(component_sample.compound_samples).to match_array [compound_sample]
    end

    it 'uses the custom timestamp columns in the association' do
      expect(compound_sample.joins_as_compound_sample.size).to be 1
      association = compound_sample.joins_as_compound_sample.first

      expect(association.recorded_at).not_to be_nil
      expect(association.last_updated).not_to be_nil
    end

    it 'destroys the association when compound_sample is destroyed' do
      compound_sample.destroy
      component_sample.reload

      expect(component_sample.compound_samples).to be_empty
      expect(SampleCompoundComponent.count).to be 0
    end

    it 'destroys the association when component_sample is destroyed' do
      component_sample.destroy
      compound_sample.reload

      expect(compound_sample.component_samples).to be_empty
      expect(SampleCompoundComponent.count).to be 0
    end
  end
end
