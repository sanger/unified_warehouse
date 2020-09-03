require 'spec_helper'

RSpec.describe LighthouseSample, type: :model do
  describe '#create' do
    # these use begin / rescue rather than valid? because the validation is database-level
    it 'can be inserted' do
      errored = false
      begin
        lh_sample = create :lighthouse_sample
      rescue
        errored = true
      end

      expect(errored).to eq(false)
    end

    it 'errors without an rna id' do
      errored = false
      begin
        lh_sample = create :lighthouse_sample, rna_id: nil
      rescue
        errored = true
      end

      expect(errored).to eq(true)
    end

    it 'errors without a result' do
      errored = false
      begin
        lh_sample = create :lighthouse_sample, result: nil
      rescue
        errored = true
      end

      expect(errored).to eq(true)
    end

    it 'errors without a root sample id' do
      errored = false
      begin
        lh_sample = create :lighthouse_sample, root_sample_id: nil
      rescue
        errored = true
      end

      expect(errored).to eq(true)
    end

    it 'errors if it is a duplicate' do
      create :lighthouse_sample

      errored = false
      begin
        lh_sample = create :lighthouse_sample
      rescue
        errored = true
      end

      expect(errored).to eq(true)
    end

    it 'inserts if the key fields are unique' do
      create :lighthouse_sample

      errored = false
      begin
        lh_sample = create :lighthouse_sample, root_sample_id: 'new', rna_id: 'new', result: 'new', mongodb_id: 'new'
      rescue
        errored = true
      end

      expect(errored).to eq(false)
    end
  end
end
