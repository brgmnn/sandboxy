#
#   Template
#

class Sandboxy::Template
  IDSPACE = 30

  def self.wrap(path)
    _, slug, ext = Sandboxy::Path.new(path).info
    language = Sandboxy::Language.get(ext)

    templates = (Dir["templates/#{language}/#{slug}.#{ext}.erb"] \
      + Dir["templates/#{language}/#{slug}/*.#{ext}.erb"])
      .map { |p| File.expand_path(p) }

    # If there are no templates to test
    return [{ id: nil, path: path }] if templates.empty?

    templates.map do |template_path|
      tmp_path = Tempfile.new.path
      template = new(path, template_path)

      File.open(tmp_path, 'w') do |f|
        f.write template.output
      end

      { id: template.id, path: tmp_path, suite_path: template_path }
    end
  end

  attr_reader :id

  def initialize(path, template_path)
    _, _, ext = Sandboxy::Path.new(path).info

    extend Sandboxy::Language.get_class(ext)

    @id = Random.rand(10**IDSPACE)
    @solution = File.read(path)
    @template = ERB.new(File.read(template_path), nil, nil, '@output')
  end

  def output
    @result ||= @template.result(binding)
  end
end
