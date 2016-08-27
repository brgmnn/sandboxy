module Sandboxy::Language::Ruby
  extend Sandboxy::Language::Base

  self::CMD = 'ruby'.freeze

  def pass
    "puts '#{@id} test passed'"
  end

  def fail
    "puts '#{@id} test failed'"
  end

  def assert
    @output << 'if ('
    yield
    @output << ")\n  #{pass}\nelse\n  #{fail}\nend"
  end
end
