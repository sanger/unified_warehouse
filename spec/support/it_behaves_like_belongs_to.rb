shared_examples_for 'belongs to' do |belonging_owners, belonging_owned|
  let!(:json_handler) { described_class.send(:json) }

  def find_target(json,graph)
    return json[graph].first if graph.is_a?(Symbol)
    k,v = graph.first
    find_target(json[k].first,v)
  end

  def find_handler(handler,graph)
    return handler.nested_models[graph] if graph.is_a?(Symbol)
    k,v = graph.first
    find_handler(handler.nested_models[k],v)
  end

  let(:example_lims) { 'example' }

  subject { json_handler.collection_from(json,example_lims) }

  let!(:owning_json)   { find_target(json,belonging_owned) }

  belonging_owners.each do |owner|

    context "#{owner}" do
      let(:owning_handler) { find_handler(json_handler,belonging_owned)}

      let(:id)   { owning_json[:"#{owner}_id"] }
      let(:uuid) { owning_json[:"#{owner}_uuid"] }

      let!(:mock_owner_instnace) {double("mock_#{owner}",:"id_#{owner}_tmp"=>12345)}
      let!(:mock_owner) { double("mock_#{owner}_array", :first=>mock_owner_instnace)}
      let!(:mock_scope) { double("mock_scope")}
      let(:owner_class) { owner.to_s.classify.constantize }

      before(:each) do
        expect_any_instance_of(described_class).to receive(:"#{owner}=").with(mock_owner_instnace).and_return(true)
      end

      it "should look up the corresponding #{owner} entry for #{belonging_owned.to_a.flatten.join('=>')}" do
        allow(mock_scope).to  receive(:with_id).with(id).and_return(mock_owner)
        allow(owner_class).to receive(:for_lims).with(example_lims).and_return(mock_scope)
        allow(owner_class).to receive(:with_uuid).with(uuid).and_return(mock_owner)
      end

    end

  end

  after(:each) do
    described_class.send(:create_or_update, subject.detect {|json| json.class == owning_handler })
  end
end
