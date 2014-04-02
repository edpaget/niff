require 'niff/dsl'

describe Niff::DSLExec do
  let(:file) { file = File.join(File.dirname(__FILE__), "../test_cluster.rb") } 
  it 'should successfully load test_cluster.rb file' do
    expect{ Niff::DSLExec.from_file(file) }.to_not raise_error
  end

  it 'should return a hash containing defined environments' do
    envs = Niff::DSLExec.from_file(file)
    expect(envs).to be_a(Hash)
    expect(envs).to have_key(:test)
  end
end
