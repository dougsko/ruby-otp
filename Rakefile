# Rakefile for ruby-otp
#
#

require 'yaml'
require 'rubygems'

begin
    require 'jeweler'
    Jeweler::Tasks.new do |s|
        s.name = "ruby-otp"
        #s.executables = "jeweler"
        s.summary = "Fork of the ruby-otp project at http://rubyforge.org/projects/ruby-otp"
        s.email = "dougtko@gmail.com"
        s.homepage = "http://github.com/dougsko/ruby-otp"
        s.description = "Fork of the ruby-otp project at http://rubyforge.org/projects/ruby-otp.  This version provides support for more secure hashing algorithms."
        s.authors = ["dougsko"]
        s.files =  FileList["[A-Z]*", "{bin,generators,lib,spec}/**/*", 
            'lib/jeweler/templates/.gitignore']
        #s.add_dependency 'schacon-git'
end
rescue LoadError
    puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install 
        technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = 'ruby-otp'
    rdoc.options << '--line-numbers' << '--inline-source'
    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
    spec.libs << 'lib' << 'spec'
    spec.spec_files = FileList['spec/**/*_spec.rb']
    spec.spec_opts = ['--color', '-H']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
    spec.libs << 'lib' << 'spec'
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
    spec.spec_opts = ['--color']
end

task :default => :spec
