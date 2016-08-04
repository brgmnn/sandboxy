module Sandboxy::Commands
  def self.all
    constants.select { |c| Sandboxy::Commands.const_get(c).is_a? Class }
  end
end

require_relative 'commands/build'
require_relative 'commands/run'
