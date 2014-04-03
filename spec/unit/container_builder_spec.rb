require 'niff/dsl/container'

describe Niff::DSL::ContainerBuilder do
  let(:cb) do
    Niff::DSL::ContainerBuilder.new(:test, {environments: {},
                                            nodes: {},
                                            containers: {},
                                            services: {},
                                            volumes: {}})
      
  end

  before(:each) {@c = cb}

  describe "#image" do
    it "should assign an image name" do
      @c.image("docker.example.com/test-image")
      expect(@c.instance_variable_get(:@image)).to eq("docker.example.com/test-image")
    end
  end

  describe "#image_version" do
    it "should assign and image version" do
      @c.image_version("0.9.0")
      expect(@c.instance_variable_get(:@image_version)).to eq("0.9.0")
    end
  end

  describe "#arguments" do
    it "should assign the container's arguments" do
      @c.arguments "--test-flag", "test.argument"
      expect(@c.instance_variable_get(:@args)).to eq(["--test-flag", "test.argument"])
    end

    it "should also accept the arguments as an array" do
      @c.arguments ["--test-flag", "test.argument"]
      expect(@c.instance_variable_get(:@args)).to eq(["--test-flag", "test.argument"])
    end
  end

  describe "#config_dir" do
    it "should assign a directory for config files to be mounted" do
      @c.config_dir("/opt/config")
      expect(@c.instance_variable_get(:@config_dir)).to eq("/opt/config")
    end
  end

  describe "#port" do
    it "should assign a port" do
      @c.port("9092:9092")
      expect(@c.instance_variable_get(:@port)).to eq("9092:9092")
    end
  end

  describe "#build" do
    it "should return a Niff::Container" do
      expect(cb.build).to be_a(Niff::Container)
    end
  end

end
