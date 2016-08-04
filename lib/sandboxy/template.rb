#
#   Template
#

class Sandboxy::Template
  IDSPACE = 30

  def self.wrap(path)
    _, slug, ext = Sandboxy::Path.new(path).info
    language = Sandboxy::Language.get(ext)
    langclass = Sandboxy::Language.get_class(ext)

    templates = (Dir["templates/#{language}/#{slug}.#{ext}.erb"] \
      + Dir["templates/#{language}/#{slug}/*.#{ext}.erb"])
      .map { |p| File.expand_path(p) }

    # If there are no templates to test
    return [{ id: nil, path: path }] if templates.nil?

    templates.map do |template_path|
      @id = Random.rand(10**IDSPACE)
      @pass = langclass.pass(@id)
      @fail = langclass.fail(@id)

      if File.exist?(template_path)
        @solution = File.read(path)

        template = ERB.new(File.read(template_path))
        tmp_path = Tempfile.new.path

        File.open(tmp_path, 'w') do |f|
          f.write(template.result(binding))
        end
      end

      { id: @id, path: tmp_path, suite_path: template_path }
    end
  end
end
