shared_examples_for 'belongs to' do |belonging_owners, belonging_owned|
  let!(:json_handler) { described_class.send(:json) }

  def find_target(json, graph)
    return json if graph.nil?
    return json[graph.to_s].first if graph.is_a?(Symbol)
    return json[graph.first.to_s].first if graph.count == 1 && graph.first.is_a?(Symbol)

    k, v = graph.first
    find_target(json[k.to_s].first, v)
  end

  def find_handler(handler, graph)
    return handler if graph.nil?
    return handler.nested_models[graph] if graph.is_a?(Symbol)
    return handler.nested_models[graph.first] if graph.count == 1 && graph.first.is_a?(Symbol)

    k, v = graph.first
    find_handler(handler.nested_models[k], v)
  end

  let(:example_lims) { 'example' }

  subject { json_handler.collection_from(json, example_lims) }

  let!(:owning_json) { find_target(json, belonging_owned) }

  belonging_owners.each do |owner|
    context owner.to_s do
      let(:owning_handler) { find_handler(json_handler, belonging_owned) }

      let(:id)   { owning_json[:"#{owner}_id"] }
      let(:uuid) { owning_json[:"#{owner}_uuid"] }

      let(:owner_class) { owner.to_s.classify.constantize }

      it "should look up the corresponding #{owner} entry for #{belonging_owned.to_a.flatten.join('=>')}" do
        expect_any_instance_of(described_class).to receive(:"#{owner}=").with(kind_of(owner_class)).and_call_original
      end
    end
  end

  after(:each) do
    content = subject.is_a?(Array) ? subject.detect { |json| json.instance_of?(owning_handler) } : subject
    described_class.send(:create_or_update, content)
  end
end
