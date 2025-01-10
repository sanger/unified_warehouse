# frozen_string_literal: true

shared_examples_for 'a singular resource versioned' do
  let(:originally_created_at) { Time.zone.parse('2012-Mar-16 12:06') }
  let(:timestamped_json) { json.merge('created_at' => originally_created_at, 'last_updated' => originally_created_at) }
  let(:modified_at) { originally_created_at + 1.day }
  let(:checked_time_now) { Time.parse('2012-Mar-26 13:20').utc }
  let(:checked_time_then) { Time.parse('2012-Mar-25 13:20').utc }
  let(:example_lims) { 'example' }

  let(:attributes) { described_class.send(:json).new(timestamped_json) }

  def current_records
    ActiveRecord::Base.connection.select_all("SELECT * FROM #{described_class.table_name}")
  end

  context '.create_or_update_from_json' do
    context 'from different lims' do
      let(:second_lims) { 'example_2' }

      before(:each) do
        described_class.create_or_update_from_json(timestamped_json.merge('last_updated' => modified_at), example_lims)
        described_class.create_or_update_from_json(timestamped_json.merge('last_updated' => modified_at, 'uuid' => 'other'), second_lims)
      end

      it 'creates multiple records' do
        expect(current_records.count).to eq(2)
      end
    end

    context 'without existing records' do
      let(:recorded_time) { checked_time_now }

      context 'when the record is new' do
        let(:most_recent_time) { originally_created_at }
        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.create_or_update_from_json(timestamped_json, example_lims)
        end

        it_behaves_like 'has only one row'
      end
    end

    context 'with an existing record' do
      before(:each) do
        allow(described_class).to receive(:checked_time_now).and_return(checked_time_then)
        described_class.create_or_update_from_json(timestamped_json.merge('last_updated' => modified_at), example_lims)
      end

      context 'when the new record is not current' do
        before(:each) do
          described_class.send(:create_or_update, attributes.merge('last_updated' => modified_at - 2.hours, :id_lims => example_lims))
        end

        it 'only has the current row in the view' do
          expect(current_records.count).to eq(1)
          expect(current_records.first['last_updated']).to eq(modified_at)
        end
      end

      context 'when the fields are unchanged' do
        let(:most_recent_time) { modified_at }
        let(:recorded_time) { checked_time_then }

        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.create_or_update_from_json(timestamped_json.merge('last_updated' => modified_at), example_lims)
        end

        it_behaves_like 'has only one row'
      end

      context 'when the fields change in latest update' do
        let(:most_recent_time) { modified_at }
        let(:recorded_time) { checked_time_then }

        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.create_or_update_from_json(timestamped_json.merge('last_updated' => modified_at + 1.hour, attribute_to_change => new_value), example_lims)
        end

        it 'creates a new record with the updated fields' do
          expect(current_records.count).to eq(2)
          expect(current_records.last[attribute_to_change]).to eq(new_value)
          expect(current_records.last['last_updated']).to eq(modified_at + 1.hour)
        end
      end

      context 'when the fields are not changed in latest update' do
        let(:most_recent_time) { modified_at }
        let(:recorded_time) { checked_time_then }

        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.create_or_update_from_json(timestamped_json.merge('last_updated' => modified_at + 1.hour), example_lims)
        end

        it 'creates a new record with the updated fields' do
          expect(current_records.count).to eq(1)
          expect(current_records.last['last_updated']).to eq(modified_at)
        end
      end

      context 'when ignored fields change' do
        ResourceTools::IGNOREABLE_ATTRIBUTES.each do |attribute|
          next if attribute.to_s == 'dont_use_id' # Protected by mass-assignment!

          let(:most_recent_time) { modified_at }
          let(:recorded_time) { checked_time_then }

          context "when #{attribute.to_sym.inspect} changes" do
            before(:each) do
              # We have to account for attribute translation, so process through the JSON handler
              # and then update the attribute.
              allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
              attributes[attribute] = 'changed'
              described_class.send(:create_or_update, attributes.merge('last_updated' => modified_at, :id_lims => example_lims))
            end

            it_behaves_like 'has only one row'
          end
        end
      end
    end
  end
end
