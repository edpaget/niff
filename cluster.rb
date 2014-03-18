domain "zooniverse.org" do

  cluster :zookeepers do
    [:zk1, :zk2, :zk3].each do |n|
      node n do
        cookbook "zoo-zookeeper"
        instance_type "m1.small"
      end
    end
  end

  node :kafka1 do
    cookbook "zoo-kafka"
    instance_type "m3.large"
    virtual_box_opts({memory: 2048, cpus: 2})
  end
end
