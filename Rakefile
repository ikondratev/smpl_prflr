require 'rubygems'
require 'rake'

desc "Run spec"
task default: %i[test]

require 'rake/testtask'
Rake::TestTask.new do |test|
  test.libs << 'test'
end