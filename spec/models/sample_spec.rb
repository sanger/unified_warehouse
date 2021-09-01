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
end
