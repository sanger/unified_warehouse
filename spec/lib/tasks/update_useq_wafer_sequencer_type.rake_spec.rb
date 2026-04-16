# frozen_string_literal: true

require 'spec_helper'
require 'rake'

Rails.application.load_tasks if Rake::Task.tasks.empty?

RSpec.describe 'RakeTasks' do
  describe 'useq_wafer_table:update_sequencer_type_to_ug100' do
    let(:sample) { create(:sample, :with_uuid_sample_lims) }
    let(:study) { create(:study, :with_uuid_study_lims) }

    let!(:wafer_with_nil_sequencer) { create_useq_wafer(sample:, study:, request_order: 1, sequencer_type: nil) }
    let!(:wafer_with_existing_sequencer) { create_useq_wafer(sample:, study:, request_order: 2, sequencer_type: 'EXISTING_TYPE') }
    let!(:another_wafer_with_nil) { create_useq_wafer(sample:, study:, request_order: 3, sequencer_type: nil) }

    before do
      Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].reenable
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('COMMIT').and_return(nil)
    end

    describe 'without COMMIT flag (preview mode)' do
      it 'does not update sequencer_type when COMMIT is not set' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.not_to(change { wafer_with_nil_sequencer.reload.sequencer_type })
      end

      it 'outputs preview message with would update count' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to output(/Would update 2 records with sequencer_type='UG100'/).to_stdout
      end

      it 'outputs no commit yet message' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to output(/no commit yet/i).to_stdout
      end

      it 'outputs record IDs to be updated' do
        expected_output = /Record IDs to update:.*#{wafer_with_nil_sequencer.id_useq_wafer_tmp}.*#{another_wafer_with_nil.id_useq_wafer_tmp}/m

        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to output(expected_output).to_stdout
      end
    end

    describe 'with COMMIT=true flag' do
      before do
        allow(ENV).to receive(:[]).with('COMMIT').and_return('true')
      end

      it 'updates sequencer_type to UG100 for records with nil sequencer_type' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to(
          change { wafer_with_nil_sequencer.reload.sequencer_type }.from(nil).to('UG100').and(
            change { another_wafer_with_nil.reload.sequencer_type }.from(nil).to('UG100')
          )
        )
      end

      it 'does not update record that already has a sequencer_type' do
        old_type = wafer_with_existing_sequencer.sequencer_type

        Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke

        expect(wafer_with_existing_sequencer.reload.sequencer_type).to eq(old_type)
      end

      it 'outputs success message with updated count' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to output(/Successfully updated 2 records with sequencer_type='UG100'/).to_stdout
      end
    end

    describe 'when no records need updating' do
      before do
        UseqWafer.where(sequencer_type: nil).find_each { |wafer| wafer.update!(sequencer_type: 'UG100') }
      end

      it 'outputs found 0 records message' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to output(/Found 0 records with nil sequencer_type/).to_stdout
      end

      it 'outputs would update 0 records message' do
        expect do
          Rake::Task['useq_wafer_table:update_sequencer_type_to_ug100'].invoke
        end.to output(/Would update 0 records with sequencer_type='UG100'/).to_stdout
      end
    end

    def create_useq_wafer(sample:, study:, request_order:, sequencer_type:)
      UseqWafer.create!(
        last_updated: Time.current,
        recorded_at: Time.current,
        id_sample_tmp: sample.id_sample_tmp,
        id_study_tmp: study.id_study_tmp,
        id_wafer_lims: "wafer_lims_#{request_order}",
        batch_for_opentrons: "batch_#{request_order}",
        id_lims: 'SQSCP',
        request_order:,
        entity_type: 'library_indexed',
        tag_sequence: "tag_#{request_order}",
        id_pool_lims: "pool_#{request_order}",
        entity_id_lims: "entity_#{request_order}",
        sequencer_type:
      )
    end
  end
end
