class Sandboxy::Commands::Run
  include Commander::Methods

  SYNTAX = '[options]'
  SUMMARY = 'run batch'
  DESCRIPTION = ''

  def initialize(args, options)
  end

  def run_app(language, cmd, path)
    # Create Image
    image = Docker::Image.create(fromImage: "sandboxy:#{language}")
      .insert_local('localPath' => path, 'outputPath' => '/app')

    # Create Container
    container = Docker::Container.create(Image: image.id, Cmd: cmd, Tty: true)
    container.start
    container.wait(10)

    result = container.logs(stdout: true)

    # Cleanup
    container.stop
    container.delete(force: true)
    image.remove(force: true)

    return result
  end

  def run
    puts 'Running'.light_blue

    progress Dir['code/**/*.*'] do |path|
      file = File.basename(path)
      ext = File.extname(path)[1..-1]

      print file.bold

      File.open(path.gsub(file, 'stdout'), "w") do |f|
        case ext
        when 'js'
          f.puts run_app('javascript', ['nodejs', "/app/#{file}"], path)
        when 'py'
          f.puts run_app('python', ['python', "/app/#{file}"], path)
        when 'rb'
          f.puts run_app('ruby', ['ruby', "/app/#{file}"], path)
        end
      end
    end
  end
end
