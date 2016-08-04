require 'yaml'

module Sandboxy::Config; end

module Sandboxy::Config::Containers
  CREATE = YAML.load_file(Sandboxy.path('config/containers/create.yml'))
    .symbolize_keys
end
