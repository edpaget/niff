require 'niff/dsl/dsl_builder'

describe Niff::DSL::DSLBuilder do
  let(:env) do  
    {
      environment: {test: double("Niff::Environment")},
      service: {test_service: double("Niff::Service")},
      node: {test_node: double("Niff::Node")},
      container: {test_container: double("Niff::Container")},
      volume: {test_volume: double("Niff::Volume")},
    }
  end

  let(:builder) { Niff::DSL::DSLBuilder.new(:test_builder, env) }

  it 'should have a name' do
    expect(builder.instance_variable_get(:@name)).to equal(:test_builder)
  end

  it 'should set the env hash to proxy the parent environment' do
    expect(builder.instance_variable_get(:@env)[:environment][:test]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:service][:test_service]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:node][:test_node]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:container][:test_container]).to_not be_nil
    expect(builder.instance_variable_get(:@env)[:volume][:test_volume]).to_not be_nil
  end

end
