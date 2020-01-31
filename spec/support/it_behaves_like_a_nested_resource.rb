shared_examples_for 'has multiple rows' do
  it 'leaves the system with multiple rows' do
    expect(described_class.count).to eq(expected_entries)
  end

  it 'ensures that the all rows are current' do
    described_class.all.each do |row|
      expect(row.last_updated).to eq(most_recent_time)
    end
  end

  it 'ensures the row is marked with recorded time' do
    described_class.all.each do |row|
      expect(row.recorded_at).to eq(recorded_time)
    end
  end
end

shared_examples_for 'a nested resource' do
  let(:originally_created_at) { Time.parse('2012-Mar-16 12:06') }
  let(:timestamped_json) { json.merge("updated_at" => originally_created_at) }
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
        described_class.create_or_update_from_json(timestamped_json.merge("updated_at" => modified_at), example_lims)
        described_class.create_or_update_from_json(timestamped_json.merge("updated_at" => modified_at), second_lims)
      end

      it 'creates multiple records' do
        expect(current_records.count).to eq(expected_entries * 2)
      end
    end

    context 'without existing records' do
      let(:recorded_time) { checked_time_now }

      context 'when the record is deleted' do
        let(:most_recent_time) { modified_at }

        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.send(:create_or_update_from_json, attributes.merge("updated_at" => modified_at, "deleted_at" => modified_at), example_lims)
        end

        it 'removes matching records' do
          expect(current_records.count).to eq(0)
        end
      end

      context 'when the record is new' do
        let(:most_recent_time) { originally_created_at }
        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.create_or_update_from_json(timestamped_json, example_lims)
        end

        it_behaves_like 'has multiple rows'
      end
    end

    context 'with an existing record' do
      before(:each) do
        allow(described_class).to receive(:checked_time_now).and_return(checked_time_then)
        described_class.create_or_update_from_json(json.merge("updated_at" => modified_at), example_lims)
      end

      context 'when the new record is not current' do
        before(:each) do
          described_class.send(:create_or_update_from_json, attributes.merge("updated_at" => modified_at - 2.hours), example_lims)
        end

        it 'keeps the original rows' do
          expect(current_records.count).to eq(expected_entries)
          expect(current_records.map { |cr| cr['last_updated'] }).to all eq(modified_at)
        end
      end

      context 'when the fields are unchanged' do
        let(:most_recent_time) { modified_at }
        let(:recorded_time) { checked_time_then }

        before(:each) do
          allow(described_class).to receive(:checked_time_now).and_return(checked_time_now)
          described_class.create_or_update_from_json(json.merge("updated_at" => modified_at), example_lims)
        end

        it_behaves_like 'has multiple rows'
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
              described_class.send(:create_or_update_from_json, attributes.merge("updated_at" => modified_at), example_lims)
            end

            it_behaves_like 'has multiple rows'
          end
        end
      end
    end
  end
end
