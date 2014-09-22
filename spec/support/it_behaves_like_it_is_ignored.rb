shared_examples_for 'it is ignored' do
  subject { described_class.create_or_update_from_json }

  context '#inserted_record?' do
    it 'is always true' do
      expect(subject).to_not be_inserted_record
    end
  end

  context '#id' do
    it 'is ignored' do
      expect(subject.id).to eq('ignored')
    end
  end
end
