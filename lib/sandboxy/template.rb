#
#   Template
#

class Sandboxy::Template
  IDSPACE = 30

  def self.wrap(path)
    @id = nil
    _, slug, ext = Sandboxy::Path.new(path).info

    language = Sandboxy::Language.get(ext)
    template_path = File.expand_path(
      "templates/#{language}/#{slug}/run.#{ext}.erb"
    )

    if File.exists?(template_path)
      @solution = File.read(path)
      @id = Random.rand(10**IDSPACE)

      template = ERB.new(File.read(template_path))
      path = Tempfile.new.path

      File.open(path, 'w') do |f|
        f.write(template.result(binding))
      end
    end

    return @id, path
  end
end
