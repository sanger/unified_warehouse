require 'spec_helper'
require './lib/postman/message'

RSpec.describe Postman::Message, type: :lib do
  let(:postman) do
    instance_double('Postman', main_exchange: main_exchange, delay_exchange: delay_exchange, max_retries: 2, requeue_key: 'requeue.test')
  end
  let(:main_exchange) { instance_double('Postman::Channel', 'main_exchange') }
  let(:delay_exchange) { instance_double('Postman::Channel', 'delay_exchange') }
  let(:delivery_info) { instance_double('Bunny::DeliveryInfo', delivery_tag: 'delivery_tag', routing_key: 'test.key') }
  let(:metadata) { instance_double('Bunny::MessageProperties', headers: { 'attempts' => retry_attempts }) }
  let(:retry_attempts) { 0 }
  let(:payload) { instance_double('Payload') }
  subject { described_class.new(postman, delivery_info, metadata, payload) }

  let(:payload) { %({"sample":{},"lims":"test"}) }

  context "with a valid payload" do
    before do
      expect(Payload).to receive(:from_json).with(payload).and_return(payload)
      expect(payload).to receive(:record).and_return(true)
      expect(main_exchange).to receive(:ack).with('delivery_tag')
    end

    it "can be processed" do
      subject.process
    end
  end

  context "with an invalid payload" do
    before do
      expect(Payload).to receive(:from_json).with(payload).and_raise(Payload::InvalidMessage)
      expect(main_exchange).to receive(:nack).with('delivery_tag')
    end

    it "can be processed" do
      subject.process
    end
  end

  context "with a temporarily invalid payload" do
    context 'with no retries' do
      before do
        expect(Payload).to receive(:from_json).with(payload).and_return(payload)
        expect(payload).to receive(:record).and_raise(ActiveRecord::RecordInvalid)
        expect(main_exchange).to receive(:ack).with('delivery_tag')
        expect(delay_exchange).to receive(:publish).with(payload, routing_key: 'requeue.test', headers: { attempts: 1 })
      end

      it "can be processed" do
        subject.process
      end
    end

    context 'with no retries' do
      let(:retry_attempts) { 3 }

      before do
        expect(Payload).to receive(:from_json).with(payload).and_return(payload)
        expect(payload).to receive(:record).and_raise(ActiveRecord::RecordInvalid)
        expect(main_exchange).to receive(:nack).with('delivery_tag')
      end

      it "can be processed" do
        subject.process
      end
    end
  end

  context 'with database issues' do
    before do
      expect(Payload).to receive(:from_json).with(payload).and_return(payload)
      expect(payload).to receive(:record).and_raise(ActiveRecord::StatementInvalid, "Mysql2::Error: Can't connect to local MySQL server through socket '/tmp/mysql.sock'")
      expect(main_exchange).to receive(:nack).with('delivery_tag', false, true)
      expect(postman).to receive(:pause!)
    end

    it "can be processed" do
      subject.process
    end
  end
end
