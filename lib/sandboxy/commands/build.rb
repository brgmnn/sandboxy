class Sandboxy::Commands::Build
  include Commander::Methods

  SYNTAX = '[options]'
  SUMMARY = 'hello'
  DESCRIPTION = ''

  def initialize(args, options)
  end

  def run
    puts 'Building Images'.light_blue

    dockerfiles = Dir[File.expand_path('images/*.dockerfile', Sandboxy::App::PATH)]

    progress dockerfiles do |path|
      dockerfile = File.basename(path)
      tag = File.basename(path, '.dockerfile')

      print dockerfile.bold
      image = Docker::Image.build_from_dir(File.dirname(path), { 'dockerfile': dockerfile })

      image.tag(repo: 'sandboxy', tag: tag, force: true)
    end
  end
end
