require 'niff/dsl/dsl_builder'

describe Niff::DSL::DSLBuilder do
  let(:env) do  
    {
      environments: {test: double("Niff::Environment")},
      services: {test_service: double("Niff::Service")},
      nodes: {test_node: double("Niff::Node")},
      containers: {test_container: double("Niff::Container")}
    }
  end

  let(:builder) { Niff::DSL::DSLBuilder.new(:test_builder, env) }

  it 'should have a name' do
    expect(builder.instance_variable_get(:@name)).to equal(:test_builder)
  end

  it 'should set the env hash to proxy the parent environment' do
    expect(builder.instance_variable_get(:@env)[:environments][:test]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:services][:test_service]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:nodes][:test_node]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:containers][:test_container]).to_not be_nil
  end

end
