class Sandboxy::Container::Image
  def self.run(language, cmd, path)
    # Create Image
    image = Docker::Image.create(fromImage: "sandboxy:#{language}")
      .insert_local(
        'localPath' => path,
        'outputPath' => '/app'
      )

    # Create Container
    container = Docker::Container.create(
      Image: image.id,
      Cmd: cmd,
      Tty: true,
      **Sandboxy::Config::Containers::CREATE
    )

    profile = {}

    begin
      container.start
      profile = {
        status_code: container.wait(2)['StatusCode'],
        killed: false
      }
    rescue Docker::Error::TimeoutError
      profile = { status_code: 1, killed: true }
    end

    stdout = container.logs(stdout: true)
    stderr = container.logs(stderr: true)

    # Cleanup
    container.stop
    container.delete(force: true)
    image.remove(force: true)

    [stdout, stderr, profile]
  end
end
