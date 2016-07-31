#
#   Template
#

class Sandboxy::Template
  IDSPACE = 30

  def self.wrap(path)
    @id = Random.rand(10**IDSPACE)
    _, slug, ext = Sandboxy::Path.new(path).info

    language = Sandboxy::Language.get(ext)
    langclass = Sandboxy::Language.get_class(ext)

    @pass = langclass.pass(@id)
    @fail = langclass.fail(@id)

    template_path = File.expand_path(
      "templates/#{language}/#{slug}/run.#{ext}.erb"
    )

    template_path = File.expand_path(
      "templates/#{language}/#{slug}.#{ext}.erb"
    ) unless File.exists?(template_path)

    if File.exists?(template_path)
      @solution = File.read(path)

      template = ERB.new(File.read(template_path))
      path = Tempfile.new.path

      File.open(path, 'w') do |f|
        f.write(template.result(binding))
      end
    end

    return @id, path
  end
end
