require 'rubygems'
require 'erb'
require 'json'
require 'pry'

require 'commander'
require 'docker'
require 'colorize'
require 'active_support'
require 'active_support/core_ext'

module Sandboxy
  PATH = File.expand_path('../../', __FILE__).freeze

  def self.path(p)
    File.expand_path(p, PATH)
  end
end

require_relative 'sandboxy/ui'
require_relative 'sandboxy/patch'

require_relative 'sandboxy/commands'
require_relative 'sandboxy/config'
require_relative 'sandboxy/container'
require_relative 'sandboxy/language'
require_relative 'sandboxy/path'
require_relative 'sandboxy/template'

require_relative 'sandboxy/app'
