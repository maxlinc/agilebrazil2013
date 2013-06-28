require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => [:whitespace, :validate, :lint, 'hiera:validate', :spec ]

Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
