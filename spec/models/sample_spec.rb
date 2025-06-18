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
    it 'should raiser an error if uuid is null' do
      expect { create(:sample, uuid_sample_lims: nil) }.to raise_error ActiveRecord::NotNullViolation
    end
  end

  context 'compound samples via JSON' do
    let(:originally_created_at) { Time.zone.parse('2012-Mar-16 12:06') }
    let(:modified_at) { originally_created_at + 1.day }
    let(:example_lims) { 'example' }
    let(:component_sample) { create(:sample, uuid_sample_lims: '012345-6789-UUID-0002') }
    let(:json) do
      {
        updated_at: originally_created_at,
        created_at: originally_created_at,
        uuid: '012345-6789-UUID-0001',
        id: 12_345,
        name: 'compound_sample',
        component_sample_uuids: [{ uuid: component_sample[:uuid_sample_lims] }]
      }
    end

    context 'when erroneous JSON is received' do
      let!(:sample_json_received) do
        {
          id: 12_345,
          name: 'compound_12345',
          uuid: '012345-6789-UUID-0001',
          component_samples: [
            {
              uuid: '012345-6789-UUID-0002'
            },
            {
              uuid: '012345-6789-UUID-0003'
            }
          ]
        }
      end

      it 'tries to create a sample with an improper schema' do
        expect do
          described_class.create_or_update_from_json(sample_json_received, example_lims)
        end.to raise_error(ActiveRecord::AssociationTypeMismatch)
      end
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
      modified_json = json.merge({ component_sample_uuids: [{ uuid: 'MADE_UP_UUID' }] })

      expect do
        described_class.create_or_update_from_json(modified_json, example_lims)
      end.to raise_error ActiveRecord::RecordNotFound, "No sample with uuid 'MADE_UP_UUID'"
    end

    context 'compound sample already has a component sample' do
      let!(:other_component) { create(:sample, uuid_sample_lims: '012345-6789-UUID-9999') }
      let!(:compound_sample) do
        create(
          :sample,
          uuid_sample_lims: json[:uuid],
          id_sample_lims: json[:id],
          name: json[:name]
        )
      end

      before(:each) do
        compound_sample.component_samples = [other_component]
        compound_sample.reload
        component_sample.reload
      end

      it 'can update the association between compound and component sample' do
        # Sanity check
        expect(compound_sample.component_samples).to match_array [other_component]
        expect(other_component.compound_samples).to match_array [compound_sample]
        expect(component_sample.compound_samples).to be_empty

        updated_json = json.merge(updated_at: modified_at)
        described_class.create_or_update_from_json(updated_json, example_lims)

        expect(Sample.count).to be 3
        expect(SampleCompoundComponent.count).to be 1

        compound_sample.reload
        component_sample.reload
        other_component.reload

        expect(compound_sample.component_samples).to match_array [component_sample]
        expect(component_sample.compound_samples).to match_array [compound_sample]
        expect(other_component.compound_samples).to be_empty
      end
    end
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
