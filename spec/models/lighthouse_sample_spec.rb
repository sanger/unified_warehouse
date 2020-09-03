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

    it "allows you to manually set the Rails timestamp fields" do
      lh_sample = create :lighthouse_sample, created_at: nil, updated_at: nil

      expect(lh_sample.created_at).not_to eq(nil)
      expect(lh_sample.updated_at).not_to eq(nil)
    end

    it "sets the Rails timestamp fields automatically if you don't specify them" do
      lh_sample = create :lighthouse_sample

      expect(lh_sample.created_at).to eq(DateTime.new(2020, 04, 02, 1, 0, 0))
      expect(lh_sample.updated_at).to eq(DateTime.new(2020, 04, 02, 1, 0, 0))
    end
  end
end
