require 'niff/environment/vagrant'

describe Niff::Environment::Vagrant do
  let(:vagrant) do 
    Niff::Environment::Vagrant.new(:testing, nil, 'local')
  end

  describe "#create_environment" do
    before(:each) do 
      nodes = [double("Niff::Node", name: :test,
                                    cookbook: "zoo-test",
                                    hostname: "tester",
                                    qualify: "tester.example.local",
                                    vb_opts: {})]
      @d = double("Niff::Domain", clusters: [], nodes: [])
      @c = {aws_access_id: "NOT REAL", aws_secret_key: "also_not_real"}
    end

    it 'should write a Vagrantfile to the .niff dir' do
      expect(File).to receive(:write).with(".niff/Vagrantfile", "w")
      expect(vagrant.create_environment(@d, @c)).to eq('')
    end

    it 'should call create box on each node' do
      v = vagrant
      expect(v).to receive(:create_box).with(@d.nodes.first)
      v.create_environment(@d, @c)
    end

    it 'the Vagrantfile should look valid' do
    end

  end

  describe "#start_environment" do
    before(:each) { @v = vagrant }
    it 'should call vagrant up' do
      expect(@v).to receive(:exec).with("VAGRANT_CWD=.niff/ vagrant up")
      @v.start_environment
    end

    it 'should concat nodes names to start into a string' do
      expect(@v).to receive(:exec)
        .with("VAGRANT_CWD=.niff/ vagrant up zk1 zk2 zk3")
      @v.start_environment(:zk1, :zk2, :zk3)
    end
  end
end
