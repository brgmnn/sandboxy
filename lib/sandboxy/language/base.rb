module Sandboxy::Language::Base
  def run(path)
    file = File.basename(path)

    Sandboxy::Container::Image.run(
      name.downcase.split('::').last,
      [self::CMD, "/app/#{file}"],
      path
    )
  end

  def pass(_id)
    raise NotImplementedError
  end

  def fail(_id)
    raise NotImplementedError
  end

  def assert(_id)
    raise NotImplementedError
  end
end
