module Sandboxy::Language::C
  extend Sandboxy::Language::Base

  def pass
    "printf(\"#{@id} test passed\");"
  end

  def fail
    "printf(\"#{@id} test failed\");"
  end

  def assert
    @output << 'if ('
    yield
    @output << ") { #{pass} } else { #{fail} }"
  end
end
