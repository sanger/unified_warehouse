# frozen_string_literal: true

require 'warren/fox'
require 'spec_helper'

RSpec.describe Warren::Subscriber::MultiLimsWarehouseConsumer, type: :lib do
  subject(:event_consumer) do
    described_class.new(fox, delivery_info, properties, payload)
  end

  let(:fox) { instance_spy(Warren::Fox) }
  let(:delivery_info) { instance_spy(Bunny::DeliveryInfo) }
  let(:properties) { instance_spy(Bunny::MessageProperties) }
  let(:payload) { 'A message' }

  describe '#process' do
    before do
      allow(Payload).to receive(:from_json).and_return(a_payload)
    end

    let(:a_payload) { instance_spy(Payload) }

    context 'when everything is in order' do
      before { event_consumer.process }

      it 'passes the payload to a Payload' do
        expect(Payload).to have_received(:from_json).with(payload)
      end

      it 'delegates to the existing processor' do
        expect(a_payload).to have_received(:record)
      end
    end

    context 'when a sample or study is missing' do
      before do
        allow(event_consumer).to receive(:delay)
        allow(a_payload).to receive(:record).and_raise(ActiveRecord::RecordNotFound)
        event_consumer.process
      end

      it 'delays the message' do
        expect(event_consumer).to have_received(:delay).with(an_instance_of(ActiveRecord::RecordNotFound))
      end
    end
  end
end
