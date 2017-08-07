require 'spec_helper'
require './lib/message'
require './app/models/flowcell'
require './app/models/sample'
require './app/models/flgen_plate'

RSpec.describe Message, type: :lib do
  subject(:message_from_json) { Message.from_json(message_json) }

  shared_examples 'valid json' do
    it { is_expected.to be_a(Message) }

    let(:message_json) do
      {
        model_name => json,
        'lims' => 'example'
      }.to_json
    end

    describe '#lims' do
      subject { message_from_json.lims }
      it { is_expected.to eq("example") }
    end

    describe '#model_class' do
      subject { message_from_json.model_class }
      it { is_expected.to eq(model_class) }
    end

    describe '#record' do
      subject { message_from_json.record }
      before { expect(model_class).to receive(:create_or_update_from_json).with(json, 'example').and_return(:an_object) }
      it { is_expected.to eq :an_object }
    end
  end

  context 'fluidigm' do
    let(:model_name) { 'flgen_plate' }
    let(:model_class) { FlgenPlate }
    include_examples 'fluidigm json'
    it_behaves_like 'valid json'
  end

  context 'flowcell' do
    let(:model_name) { 'flowcell' }
    let(:model_class) { Flowcell }
    include_examples 'full flowcell json'
    it_behaves_like 'valid json'
  end

  context 'sample' do
    let(:model_name) { 'sample' }
    let(:model_class) { Sample }
    include_examples 'sample json'
    it_behaves_like 'valid json'
  end

  context 'invalid json' do
    let(:message_json) { '#%2' }
    it 'raises InvalidMessage' do
      expect { subject }.to raise_error(Message::InvalidMessage)
    end
  end

  context 'without a lims key' do
    let(:model_name) { 'sample' }
    include_examples 'sample json'

    let(:message_json) do
      {
        model_name => json
      }.to_json
    end

    it 'raises InvalidMessage' do
      expect { subject }.to raise_error(Message::InvalidMessage)
    end
  end

  context 'with no model info' do
    let(:model_name) { 'sample' }
    include_examples 'sample json'

    let(:message_json) do
      {
        'lims' => 'example'
      }.to_json
    end

    it 'raises InvalidMessage' do
      expect { subject }.to raise_error(Message::InvalidMessage)
    end
  end

  context 'with no model info' do
    let(:model_name) { 'sample' }
    include_examples 'sample json'

    let(:message_json) do
      {
        'lims' => 'example'
      }.to_json
    end

    it 'raises InvalidMessage' do
      expect { subject }.to raise_error(Message::InvalidMessage)
    end
  end
end
