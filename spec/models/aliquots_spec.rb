# frozen_string_literal: true

require 'spec_helper'

describe Aliquot, type: :model do
  describe '#create' do
    it 'can be inserted' do
      errored = false
      begin
        create :aliquot
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(false)
    end

    it 'check validations on nil fields' do
      errored = false
      begin
        create :aliquot, lims_source: nil
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(true)
    end
  end
end
