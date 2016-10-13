module Sandboxy::Language::Java
  extend Sandboxy::Language::Base

  self::CMD = 'java'.freeze

  def self.run(path)
    file = File.basename(path)

    Sandboxy::Container::Image.run(
      name.downcase.split('::').last,
      [
        'sh',
        '-c',
        "mv /app/#{file} /app/App.java && javac /app/App.java && java App"
      ],
      path
    )
  end

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
