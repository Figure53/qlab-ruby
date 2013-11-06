require 'bundler/gem_tasks'
require 'rake/testtask'

gem 'rdoc'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.libs << 'qlab-ruby'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :test

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "qlab-ruby #{QLab::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
