# frozen_string_literal: true

shared_examples_for 'maintains roles correctly' do
  after(:each) do
    described_class.create_or_update_from_json(timestamped_json.merge(updated_roles).merge(updated_at:), 'example')
    users_fit_exactly(expected_roles)
  end

  it 'add new users' do
    updated_roles[:manager].push(user_with_role(:manager, 'new'))
  end

  it 'remove users who have been removed' do
    updated_roles[:manager].shift
  end
end

shared_examples_for 'associated with roles' do
  def user_with_role(role, index = nil)
    suffix = " #{index}" unless index.nil?
    { name: "#{role} name#{suffix}", email: "#{role} email#{suffix}", login: "#{role} login#{suffix}" }
  end

  def users_fit_exactly(roles)
    expect(described_class::User.count).to eq(roles.values.flatten.size)

    roles.each do |role, expected|
      keys = %i[name email login]
      found = described_class::User.where(role: role.to_s).map do |user|
        keys.index_with { |a| user[a] }
      end
      expect(found).to eq(expected)
    end
  end

  let(:additional_roles) { [] }
  let(:originally_created_at) { Time.zone.parse('2012-Mar-16 15:06') }
  let(:timestamped_json) { json.merge(created_at: originally_created_at, updated_at: originally_created_at + 1.day) }

  context 'for an existing record' do
    let(:roles)         { { manager: [user_with_role(:manager, 1), user_with_role(:manager, 2)] } }
    let(:updated_roles) { { manager: [user_with_role(:manager, 1), user_with_role(:manager, 2)] } }

    before(:each) do
      described_class.create_or_update_from_json(timestamped_json.merge(roles), 'example')
    end

    context 'where the update is classed current it does' do
      let(:updated_at) { originally_created_at + 1.5.days }
      let(:expected_roles) { updated_roles }
      it_behaves_like 'maintains roles correctly'
    end

    context 'where the update is legacy does not' do
      let(:updated_at) { originally_created_at + 6.hours }
      let(:expected_roles) { roles }
      it_behaves_like 'maintains roles correctly'
    end
  end

  context 'for new record' do
    let(:all_role_names) { %i[manager follower administrator].concat(additional_roles) }
    let(:roles) { all_role_names.index_with { |role| [user_with_role(role)] } }

    before(:each) do
      described_class.create_or_update_from_json(timestamped_json.merge(roles), 'example')
    end

    it 'maintains users' do
      users_fit_exactly(roles)
    end
  end
end
