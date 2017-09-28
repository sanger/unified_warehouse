require 'spec_helper'
require './lib/postman'

RSpec.describe Postman, type: :lib do
  # Describe state machine behaviour, then move across
  subject(:instance) do
    described_class.new(
      client: nil,
      main_exchange: nil,
      delay_exchange: nil,
      max_retries: nil,
      requeue_key: 'requeue.test'
    )
  end

  context 'initial state' do
    describe '#state' do
      subject { instance.state }
      it { is_expected.to eq :initialized }
    end
    it { is_expected.to be_alive }
    it { is_expected.not_to be_stopping }
    it { is_expected.not_to be_stopped }
    it { is_expected.not_to be_paused }
  end

  context 'starting' do
    before { instance.starting! }
    describe '#state' do
      subject { instance.state }
      it { is_expected.to eq :starting }
    end
    it { is_expected.to be_alive }
    it { is_expected.not_to be_stopping }
    it { is_expected.not_to be_stopped }
    it { is_expected.not_to be_paused }
  end

  context 'running' do
    before { instance.running! }
    describe '#state' do
      subject { instance.state }
      it { is_expected.to eq :running }
    end
    it { is_expected.to be_alive }
    it { is_expected.not_to be_stopping }
    it { is_expected.not_to be_stopped }
    it { is_expected.not_to be_paused }
  end

  context 'paused' do
    before { instance.paused! }
    describe '#state' do
      subject { instance.state }
      it { is_expected.to eq :paused }
    end
    it { is_expected.to be_alive }
    it { is_expected.not_to be_stopping }
    it { is_expected.not_to be_stopped }
    it { is_expected.to be_paused }
  end

  context 'stopping' do
    before { instance.stopping! }
    describe '#state' do
      subject { instance.state }
      it { is_expected.to eq :stopping }
    end
    it { is_expected.to be_alive }
    it { is_expected.to be_stopping }
    it { is_expected.not_to be_stopped }
    it { is_expected.not_to be_paused }
  end

  context 'stopped' do
    before { instance.stopped! }
    describe '#state' do
      subject { instance.state }
      it { is_expected.to eq :stopped }
    end
    it { is_expected.not_to be_alive }
    it { is_expected.not_to be_stopping }
    it { is_expected.to be_stopped }
    it { is_expected.not_to be_paused }
  end
end
