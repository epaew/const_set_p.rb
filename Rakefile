# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "steep/rake_task"

RSpec::Core::RakeTask.new(:rspec)
RuboCop::RakeTask.new
Steep::RakeTask.new

task default: %i[rubocop steep rspec]
