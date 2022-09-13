# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LighthouseSample, type: :model do
  describe '#create' do
    it 'errors without a labware_barcode' do
      errored = false
      begin
        create :long_read_qc_result, labware_barcode: nil
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(true)
    end

    it 'errors without a sample_id' do
      errored = false
      begin
        create :long_read_qc_result, sample_id: nil
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(true)
    end

    it 'errors without a assay_type' do
      errored = false
      begin
        create :long_read_qc_result, assay_type: nil
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(true)
    end

    it 'errors without a key' do
      errored = false
      begin
        create :long_read_qc_result, key: nil
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(true)
    end

    it 'errors without a value' do
      errored = false
      begin
        create :long_read_qc_result, value: nil
      rescue StandardError
        errored = true
      end
      expect(errored).to eq(true)
    end

    describe 'units' do
      it 'inserts with a value for units' do
        qc_result = create :long_read_qc_result, units: 'unit1'
        expect(qc_result.units).to be_truthy
      end

      it 'is nullable' do
        qc_result = create :long_read_qc_result, units: nil
        expect(qc_result.units).to be_nil
      end
    end
  end
end
