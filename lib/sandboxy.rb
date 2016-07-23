require 'rubygems'
require 'commander'
require 'docker'
require 'colorize'
require 'active_support'
require 'active_support/core_ext'

require_relative 'sandboxy/ui'
require_relative 'sandboxy/patch'
require_relative 'sandboxy/commands'

module Sandboxy
  class App
    include Commander::Methods

    PATH = File.expand_path('../../', __FILE__).freeze

    def run
      program :name, 'sandboxy'
      program :version, '0.0.1'
      program :description, 'Run a variety of programs sandboxed in containers'

      Sandboxy::Commands.constants
      .select { |c| Sandboxy::Commands.const_get(c).is_a? Class }
      .each do |cmd|

        command cmd.to_s.underscore.to_sym do |c|
          command = "Sandboxy::Commands::#{cmd}".constantize
          c.syntax = command::SYNTAX
          c.summary = command::SUMMARY
          c.description = command::DESCRIPTION
          c.example 'description', 'command example'
          c.option '--some-switch', 'Some switch that does something'

          c.action do |args, options|
            command.new(args, options).run
          end
        end
      end

      run!
    end
  end
end
