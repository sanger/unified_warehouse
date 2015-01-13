require 'spec_helper'

module ResourceTools::CoreExtensions
  describe NilClass do
    context '#latest' do
      let(:callback) do
        double(:callback).tap do |callback|
          expect(callback).to receive(:call).with(nil)
        end
      end

      it 'yields value' do
        nil.latest('value', &callback.method(:call))
      end
    end
  end

  describe Hash do
    subject { { :a => 1, :b => 2 } }

    context '#within_acceptable_bounds?' do
      it 'returns true if all values are within acceptable bounds' do
        expect(subject.within_acceptable_bounds?(:a => 1, :b => 2)).to be true
      end

      it 'returns true if all present values are within acceptable bounds' do
        expect(subject.within_acceptable_bounds?(:a => 1)).to be true
        expect(subject.within_acceptable_bounds?(:b => 2)).to be true
      end

      it 'returns false if a single value is not within acceptable bounds' do
        expect(subject.within_acceptable_bounds?(:a => 5, :b => 2)).to be false
        expect(subject.within_acceptable_bounds?(:a => 1, :b => 5)).to be false
      end
    end

    context '#reverse_slice' do
      it 'returns a hash without the specified keys' do
        expect(subject.reverse_slice(:b)).to eq({ :a => 1 })
      end

      it 'does not affect the original hash' do
        subject.reverse_slice(:b)
        expect(subject).to eq({ :a => 1, :b => 2 })
      end
    end
  end

  describe Object do
    subject { ::Object.new }

    context '#within_acceptable_bounds?' do
      it 'returns false if the object is not equal' do
        expect(subject.within_acceptable_bounds?(::Object.new)).to be false
      end

      it 'returns true if the object is equal' do
        expect(subject.within_acceptable_bounds?(subject)).to be true
      end
    end
  end

  describe String do
    subject { 'value' }

    context '#within_acceptable_bounds?' do
      it 'returns false if the value is nil' do
        expect(subject.within_acceptable_bounds?(nil)).to be false
      end

      it 'returns false if the string value is not equal' do
        expect(subject.within_acceptable_bounds?('different')).to be false
      end

      it 'returns true if the string value is equal' do
        expect(subject.within_acceptable_bounds?('value')).to be true
      end

      it 'returns true if the value is equal when converted to a string' do
        object = ::Object.new.tap do |object|
          def object.to_s
            'value'
          end
        end
        expect(subject.within_acceptable_bounds?(object)).to be true
      end
    end
  end

  describe Numeric do
    context '#within_acceptable_bounds?' do
      subject { 1.0 }

      # Values that should be acceptable.  Note that we have a small adjustment to the tolerance
      # so that we actually get within it, otherwise we're just in the situation where we're
      # trying to compare floats ... which means deltas ... which means tolerance ...
      let(:bounds) do
        tolerance_adjustment = subject.class.numeric_tolerance - 1.0e-15
        (subject-tolerance_adjustment .. subject+tolerance_adjustment)
      end

      it 'returns false if the value is nil' do
        expect(subject.within_acceptable_bounds?(nil)).to be false
      end

      it 'returns true if the value is within the upper bounds' do
        expect(subject.within_acceptable_bounds?(bounds.last)).to be true
      end

      it 'returns true if the value is within the lower bounds' do
        expect(subject.within_acceptable_bounds?(bounds.first)).to be true
      end

      it 'returns false if the value is above the upper bounds' do
        expect(subject.within_acceptable_bounds?(bounds.last + 0.00001)).to be false
      end

      it 'returns false if the value is below the lower bounds' do
        expect(subject.within_acceptable_bounds?(bounds.first - 0.00001)).to be false
      end
    end
  end

  describe Array do
    context '#convert' do

      it 'converts a single hash to an array of 1' do
        expect(::Array.convert({:example=>'example'})).to eq([{:example=>'example'}])
      end

      it 'does not modify an array of hashes' do
        expect(::Array.convert([{:example=>'example'},{:example=>'example'}])).to eq([{:example=>'example'},{:example=>'example'}])
      end

    end
  end
end
