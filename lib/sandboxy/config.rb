require 'yaml'

module Sandboxy
  module Config
    module Containers
      CREATE = YAML.load_file(Sandboxy.path('config/containers/create.yml'))
        .symbolize_keys
    end
  end
end
