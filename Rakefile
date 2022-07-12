# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "prettier"
require "prettier/rake/task"

RSpec::Core::RakeTask.new(:spec)

Prettier::Rake::Task.new { |t| t.source_files = "**/*" }

task default: :spec
