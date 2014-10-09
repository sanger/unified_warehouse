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

      let(:owner_class) { owner.to_s.classify.constantize }

      it "should look up the corresponding #{owner} entry for #{belonging_owned.to_a.flatten.join('=>')}" do
        expect_any_instance_of(described_class).to receive(:"#{owner}=").with(kind_of(owner_class)).and_call_original
      end

    end

  end

  after(:each) do
    described_class.send(:create_or_update, subject.detect {|json| json.class == owning_handler })
  end
end
