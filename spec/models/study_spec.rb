# frozen_string_literal: true

require 'spec_helper'

describe Study do
  shared_examples_for 'a study resource' do
    it_behaves_like 'a singular resource'
    it_behaves_like 'maps JSON fields', {
      id: :id_study_lims,
      sac_sponsor: :faculty_sponsor
    }

    it_behaves_like 'ignores JSON fields', %i[
      projects
      commercially_available
      samples
    ]

    it_behaves_like 'associated with roles' do
      let(:additional_roles) { %i[data_access_contact slf_manager lab_manager] }
    end

    it_behaves_like 'store as boolean', {
      'contains_human_dna' => 'Yes',
      'contaminated_human_dna' => 'No'
    }
  end

  context 'with all fields' do
    let(:json) do
      {
        'uuid' => '11111111-2222-3333-4444-555555555555',
        'id' => 1,
        'name' => 'name',
        'reference_genome' => 'reference genome',
        'ethically_approved' => true,
        'sac_sponsor' => 'faculty sponsor',
        'state' => 'state',
        'study_type' => 'study type',
        'abstract' => 'abstract',
        'abbreviation' => 'abbreviation',
        'accession_number' => 'accession number',
        'description' => 'description',
        'updated_at' => '2012-03-11 10:20:08',
        'created_at' => '2012-03-11 10:20:08',
        'contains_human_dna' => true,
        'contaminated_human_dna' => true,
        'data_release_strategy' => 'data release strategy',
        'data_release_sort_of_study' => 'data release sort of study',
        'data_release_timing' => 'data release timing',
        'data_release_delay_period' => 'data release delay period',
        'data_release_delay_reason' => 'data release delay reason',
        'data_access_group' => 'data access group',
        'ena_project_id' => 'ena project id',
        'study_title' => 'study title',
        'study_visibility' => 'study visibility',
        'ega_dac_accession_number' => 'ega dac accession number',
        'array_express_accession_number' => 'array express accession number',
        'ega_policy_accession_number' => 'ega policy accession number',
        'remove_x_and_autosomes' => true,
        'separate_y_chromosome_data' => true,
        'alignments_in_bam' => true,
        'prelim_id' => 'A1234',
        # The field may contain multiple numbers, and sometimes has comments.
        'hmdmc_number' => 'H12345; H67890; And then a comment',
        'data_destination' => 'standard',
        's3_email_list' => 'aa1@sanger.ac.uk;aa2@sanger.ac.uk',
        'data_deletion_period' => '3 months',
        'contaminated_human_data_access_group' => 'contaminated human data',
        'programme' => 'Cancer Genetics and Genomics'
      }
    end

    it_behaves_like 'a study resource'
  end

  context 'with only required fields' do
    let(:json) do
      {
        'uuid' => '11111111-2222-3333-4444-555555555555',
        'id' => 1,
        'remove_x_and_autosomes' => true,
        'alignments_in_bam' => true,
        'separate_y_chromosome_data' => true,
        'updated_at' => '2012-03-11 10:20:08'
      }
    end

    it_behaves_like 'a study resource'
  end
end
