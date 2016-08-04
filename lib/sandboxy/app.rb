class Sandboxy::App
  include Commander::Methods

  def run
    program :name, 'sandboxy'
    program :version, '0.0.1'
    program :description, <<DESCRIPTION
Run a variety of programs sandboxed in containers
DESCRIPTION

    Sandboxy::Commands.all.each do |cmd|
      command cmd.to_s.underscore.to_sym do |c|
        command = "Sandboxy::Commands::#{cmd}".constantize
        c.syntax = command::SYNTAX
        c.summary = command::SUMMARY
        c.description = command::DESCRIPTION
        c.example 'description', 'command example'
        c.option '--some-switch', 'Some switch that does something'
        c.option '--verbose', 'Verbose output'

        c.action do |args, options|
          command.new(args, options).run
        end
      end
    end

    run!
  end
end
