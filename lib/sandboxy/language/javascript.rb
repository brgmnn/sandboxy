module Sandboxy::Language::Javascript
  extend Sandboxy::Language::Base

  def pass
    "console.log('#{@id} test passed');"
  end

  def fail
    "console.log('#{@id} test failed');"
  end

  def assert
    @output << 'if ('
    yield
    @output << ") { #{pass} } else { #{fail} }"
  end
end
