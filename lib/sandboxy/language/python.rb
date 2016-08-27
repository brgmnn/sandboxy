module Sandboxy::Language::Python
  extend Sandboxy::Language::Base

  self::CMD = 'python'.freeze

  def pass
    "print '#{@id} test passed'"
  end

  def fail
    "print '#{@id} test failed'"
  end

  def assert
    @output << 'if ('
    yield
    @output << "):\n  #{pass}\nelse:\n  #{fail}\n"
  end
end
