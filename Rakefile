require 'rubygems'
require 'rake'

desc "Run spec"
task default: %i[test rubocop]

require 'rake/testtask'
Rake::TestTask.new do |test|
  test.libs << 'test'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new do |task|
  task.fail_on_error = true
  task.requires << 'rubocop-rake'
end