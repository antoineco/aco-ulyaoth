require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.with_context = true

Rake::Task["default"].clear
task :default => [:validate, :lint]
