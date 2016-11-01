#   Language
#
# Each language class owns the language specific logic for a job.

module Sandboxy::Language
  BY_EXTENSION = {
    c: 'c',
    java: 'java',
    js: 'javascript',
    py: 'python',
    rb: 'ruby'
  }.freeze

  def self.get_class(ext)
    Object.const_get(
      "Sandboxy::Language::#{BY_EXTENSION[ext.to_sym].capitalize}"
    )
  end

  def self.get(ext)
    BY_EXTENSION[ext.to_sym]
  end

  def self.supported(ext)
    !get(ext).nil?
  end
end

require_relative 'language/base'
require_relative 'language/c'
require_relative 'language/java'
require_relative 'language/javascript'
require_relative 'language/python'
require_relative 'language/ruby'
