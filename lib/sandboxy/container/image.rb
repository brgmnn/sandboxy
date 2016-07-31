class Sandboxy::Container::Image
  def self.run(language, cmd, path)
    # Create Image
    image = Docker::Image.create(fromImage: "sandboxy:#{language}")
      .insert_local('localPath' => path, 'outputPath' => '/app')

    # Create Container
    container = Docker::Container.create(
      Image: image.id,
      Cmd: cmd,
      Tty: true,
      **Sandboxy::Config::Containers::CREATE
    )
    container.start
    ran = container.wait(10)

    stdout = container.logs(stdout: true)
    stderr = container.logs(stderr: true)

    # Cleanup
    container.stop
    container.delete(force: true)
    image.remove(force: true)

    return stdout, stderr, ran['StatusCode']
  end
end
