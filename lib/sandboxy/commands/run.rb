class Sandboxy::Commands::Run
  include Commander::Methods

  SYNTAX = '[options]'
  SUMMARY = 'run batch'
  DESCRIPTION = ''

  def initialize(args, options)
  end

  def run
    results = Hash.new { |hash,key| hash[key] = {} }

    progress Dir['code/**/*.*'] do |path|
      id = path.split('/')[-2]
      file, slug, ext = Sandboxy::Path.new(path).info

      name = file.bold

      # If the question has an associated ERB template, wrap the file in the
      # template.
      template_id, path = Sandboxy::Template.wrap(path)

      # Get the language and run the file in a container runtime.
      stdout, stderr, status_code = Sandboxy::Language.get_class(ext).run(path)

      # Write to the results object.
      res = results[id][slug] = {
        ran: status_code == 0,
        stdout: stdout,
        stderr: stderr
      }

      name = name.red unless res[:ran]

      # Find any test results.
      passed = stdout.lines.select do |line|
        line =~ /#{template_id} test passed/
      end.count

      failed = stdout.lines.select do |line|
        line =~ /#{template_id} test failed/
      end.count

      total = passed + failed

      # If we have a template id and test have been run then save the test
      # results.
      unless template_id.nil? or total == 0
        res[:score] = { passed: passed, failed: failed }

        perc = res[:score][:passed] / total.to_f
        score = "#{res[:score][:passed]}/#{total}"

        score = score.light_red if perc < 0.33
        score = score.light_yellow if perc.between?(0.33, 0.66)
        score = score.light_green if perc > 0.66
      end

      print "\033[2K\r #{id.blue.bold} #{name} #{score}\n"
    end

    File.open('results.json', 'w') do |f|
      f.write(JSON.pretty_generate(results))
    end
  end
end
