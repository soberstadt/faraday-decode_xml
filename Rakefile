# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "prettier"
require "prettier/rake/task"

RSpec::Core::RakeTask.new(:spec)

module Prettier
  # Remove override of `Prettier::Rake::Task#run` once
  # https://github.com/prettier/plugin-ruby/commit/ae8c13e0c468386fee941b4f49b2752ba8c40584
  # is released.
  def self.run(args)
    quoted = args.map { |arg| arg.start_with?("-") ? arg : "\"#{arg}\"" }
    command = "node #{BINARY} --plugin \"#{PLUGIN}\" #{quoted.join(" ")}"
    opts = $stdin.tty? ? {} : { stdin_data: $stdin }

    stdout, stderr, status = Open3.capture3({ "RBPRETTIER" => "1" }, command, opts)
    $stdout.puts(stdout)

    # If we completed successfully, then just exit out.
    exitstatus = status.exitstatus
    return exitstatus if exitstatus.zero?

    if stderr.match?(%r{Cannot find module '/.+?/bin-prettier.js'})
      # If we're missing bin-prettier.js, then it's possible the user installed
      # the gem through git, which wouldn't have installed the requisite
      # JavaScript files.
      warn(<<~MSG)
        Could not find the JavaScript files necessary to run prettier.
        If you installed this dependency through git instead of from rubygems,
        it does not install the necessary files by default. To fix this you can
        either install them yourself by cd-ing into the directory where this gem
        is located (#{File.expand_path("..", __dir__)}) and running:

          `yarn install`
           or
           `npm install`
           or
           you can change the source in your Gemfile to point directly to rubygems.
      MSG
    else
      # Otherwise, just print out the same error that prettier emitted, as it's
      # unknown to us.
      warn(stderr)
    end

    # Make sure we still exit with the same status code the prettier emitted.
    exitstatus
  end

  module Rake
    class Task < ::Rake::TaskLib
      private

      # Extend rake runner to check if we're not writing
      def run_task
        Prettier.run([(write ? "--write" : "--check"), source_files])
        exit($CHILD_STATUS.exitstatus) if $CHILD_STATUS&.exited?
      end
    end
  end
end

Prettier::Rake::Task.new { |t| t.source_files = "**/*" }
Prettier::Rake::Task.new do |t|
  t.source_files = "**/*"
  t.write = false
  t.name = "prettier_check"
end

task default: :spec
