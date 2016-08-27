module Sandboxy::Language::Base
  def run(path)
    file = File.basename(path)

    Sandboxy::Container::Image.run(
      name.downcase.split('::').last,
      [self::CMD, "/app/#{file}"],
      path
    )
  end

  def pass
    raise NotImplementedError
  end

  def fail
    raise NotImplementedError
  end

  def assert
    raise NotImplementedError
  end
end
