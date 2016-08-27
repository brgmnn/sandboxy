# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength

class Sandboxy::Commands::Run
  include Commander::Methods

  SYNTAX = '[options]'.freeze
  SUMMARY = 'run batch'.freeze
  DESCRIPTION = ''.freeze

  def initialize(args, options)
  end

  def run
    results = Hash.new { |hash, key| hash[key] = {} }

    progress Dir['code/**/*.*'] do |path|
      id = path.split('/')[-2]
      file, slug, ext = Sandboxy::Path.new(path).info

      name = file.bold

      # If the question has an associated ERB template, wrap the file in the
      # template.
      templates = Sandboxy::Template.wrap(path)

      score = 0
      total = 0

      # Write to the results object.
      res = results[id][slug] = {
        tests: [],
        invalid: 0
      }

      templates.each do |t|
        tid, tpath, tsuite = t.values_at(:id, :path, :suite_path)

        # Get the language and run the file in a container runtime.
        stdout, stderr, profile = Sandboxy::Language.get_class(ext).run(tpath)

        results[id][slug][:tests] << profile.merge(
          path: tsuite,
          stdout: stdout,
          stderr: stderr
        )

        unless profile[:status_code].zero?
          name = name.red
          res[:invalid] += 1

          # Print the output for debugging purposes if it failed to run
          output = stdout[0..200].lines[0..10].map { |l| "    #{l}" }.join('')
          puts "\033[2K\r#{output}"
        end

        # Find any test results.
        passed = stdout.lines.select { |ln| ln =~ /#{tid} test passed/ }.count
        failed = stdout.lines.select { |ln| ln =~ /#{tid} test failed/ }.count

        score += passed
        total += passed + failed
      end

      # Add a score message and statistics to the result if test suites were
      # run.
      unless total.zero?
        res[:score] = { passed: score, failed: total - score }

        perc = score / total.to_f

        score_msg = "#{score}/#{total}"
        score_msg = score_msg.light_red if perc < 0.33
        score_msg = score_msg.light_yellow if perc.between?(0.33, 0.66)
        score_msg = score_msg.light_green if perc > 0.66
      end

      # Loggin information
      print "\033[2K\r #{id.blue.bold} #{name} #{score_msg}\n"
    end

    File.open('results.json', 'w') do |f|
      f.write(JSON.pretty_generate(results))
    end
  end
end
