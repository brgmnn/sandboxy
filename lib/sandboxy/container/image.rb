class Sandboxy::Container::Image
  # Shorthand to create, run and cleanup and instance
  def self.run(language, cmd, path)
    instance = new(language, cmd, path)
    stats = instance.run
    instance.cleanup

    stats
  end

  # Create a new image instance
  def initialize(language, cmd, path)
    # Create Image
    @image = Docker::Image.create(fromImage: "sandboxy:#{language}")
      .insert_local(
        'localPath' => path,
        'outputPath' => '/app'
      )

    # Create Container
    @container = Docker::Container.create(
      Image: @image.id,
      Cmd: cmd,
      Tty: true,
      **Sandboxy::Config::Containers::CREATE
    )
  end

  # Run the image instance
  def run
    profile = {}

    begin
      @container.start
      profile = {
        status_code: @container.wait(2)['StatusCode'],
        killed: false
      }
    rescue Docker::Error::TimeoutError
      profile = { status_code: 1, killed: true }
    end

    stdout = @container.logs(stdout: true)
    stderr = @container.logs(stderr: true)

    [stdout, stderr, profile]
  end

  # Cleanup the container and temporary image afterwards
  def cleanup
    @container.stop
    @container.delete(force: true)
    @image.remove(force: true)
  end
end
