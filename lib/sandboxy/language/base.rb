module Sandboxy::Language::Base
  def run(path)
    file = File.basename(path)

    return Sandboxy::Container::Image.run(
      self.name.downcase.split('::').last,
      [self::CMD, "/app/#{file}"],
      path
    )
  end
end
