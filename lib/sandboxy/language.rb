#   Language
#
# Each language class owns the language specific logic for a job.

module Sandboxy
  module Language
    BY_EXTENSION = {
      js: 'javascript',
      py: 'python',
      rb: 'ruby'
    }

    def self.get_class(ext)
      return Object.const_get(
        "Sandboxy::Language::#{BY_EXTENSION[ext.to_sym].capitalize}"
      )
    end

    def self.get(ext)
      BY_EXTENSION[ext.to_sym]
    end
  end
end

require_relative 'language/base'
require_relative 'language/javascript'
require_relative 'language/python'
require_relative 'language/ruby'
