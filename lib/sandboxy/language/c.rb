module Sandboxy::Language::C
  extend Sandboxy::Language::Base

  def self.run(path)
    file = File.basename(path)

    Sandboxy::Container::Image.run(
      name.downcase.split('::').last,
      [
        'sh',
        '-c',
        "gcc /app/#{file} -o /app/app && /app/app"
      ],
      path
    )
  end

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
