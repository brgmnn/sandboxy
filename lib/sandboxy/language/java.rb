module Sandboxy::Language::Java
  extend Sandboxy::Language::Base

  def pass
    "System.out.println(\"#{@id} test passed\");"
  end

  def fail
    "System.out.println(\"#{@id} test failed\");"
  end

  def assert
    @output << 'if ('
    yield
    @output << ") { #{pass} } else { #{fail} }"
  end
end
