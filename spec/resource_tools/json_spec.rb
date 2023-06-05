# frozen_string_literal: true

require 'spec_helper'

# Json
class Json < ResourceTools::Json::Handler
  ignore('ignored')
  translate('key' => 'translated')
end

describe ResourceTools::Json::Handler do
  context 'supports translations' do
    subject { Json.new }

    it 'does not translate keys by default' do
      subject['key'] = 'value'
      expect(subject).to have_key('key')
    end

    it 'can translate keys' do
      subject['key'] = 'value'
      expect(subject).to have_key('translated')
    end

    it 'translates updated_at to last_updated' do
      subject['updated_at'] = 'date'
      expect(subject['last_updated']).to eq('date')
    end

    it 'translates created_at to created' do
      subject['created_at'] = 'date'
      expect(subject['created']).to eq('date')
    end
  end

  context 'ignores keys' do
    subject { Json.new('ignored' => 'value') }

    it 'ignores keys on construction' do
      expect(subject).to_not have_key('ignored')
    end
  end
end
