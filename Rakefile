require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'
require 'ci/reporter/rake/rspec'


PuppetLint.configuration.fail_on_warnings = false
PuppetLint.configuration.relative = true
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.send('disable_documentation')
#PuppetLint.configuration.send('disable_single_quote_string_with_variables')
#PuppetLint.configuration.ignore_paths = ["vendor/**/*.pp", "spec/**/*.pp"]
#PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
#PuppetLint.configuration.ignore_paths = ["**/spec/**/*.pp", "**/vendor/**/*.pp"]

PuppetSyntax.exclude_paths = ["**/spec/**/*.pp", "**/vendor/**/*.pp"]

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = false
  config.ignore_paths = ["**/spec/**/*.pp", "**/vendor/**/*.pp"]
  config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
end

PuppetSyntax.exclude_paths = ["**/spec/**/*", "**/vendor/**/*"]

# Used by Jenkins to show tests report.
ENV['CI_REPORTS'] = 'reports'

desc "Run syntax, lint, and spec tests."
task :test => [
         :syntax,
         :lint,
         :spec
     ]

desc 'Cleans up and prepares blank module'
task :clean do
  puts 'Cleaning .git folder and creating README.md template'
  FileUtils.rm_rf('.git')
  File.rename('README_TEMPLATE.md', 'README.md')
end

namespace :ci do
  task :all => ['ci:setup:rspec', 'spec', 'syntax', 'lint', 'spec']
end
