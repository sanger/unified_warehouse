# frozen_string_literal: true

shared_examples_for 'maps JSON fields' do |mapped_attributes|
  let!(:json_handler) { described_class.send(:json) }

  context 'Handler' do
    subject { json_handler.new(json) }

    mapped_attributes.each do |from, to|
      it "maps #{from.inspect} to #{to.inspect}" do
        expect(subject[to]).to eq(subject[from])
      end
    end
  end
end

shared_examples_for 'ignores JSON fields' do |ignored_attributes|
  let!(:json_handler) { described_class.send(:json) }

  context 'Handler' do
    ignored_attributes.each do |name|
      it "ignores #{name.inspect}" do
        expect(json_handler.new(json.merge(name => 'ignored'))).to_not have_key(name)
      end
    end
  end
end

shared_examples_for 'store as boolean' do |boolean_fields|
  let!(:json_handler) { described_class.send(:json) }

  context 'Handler' do
    conversion = { 'Yes' => true, 'No' => false }
    boolean_fields.each do |field, value|
      it "converts #{field} to #{conversion[value]}" do
        expect(json_handler.new(json.merge(field => value)).fetch(field)).to eq(conversion[value])
      end
    end
  end
end
