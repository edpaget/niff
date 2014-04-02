environment :test do
  domain "example.com"
  docker_uri "docker.example.com"
  docker_auth "example_user", "example_pass"

  service :test_service do
    node :web_frontend do
      container :nginx do
      
      end
    end
  end

end
