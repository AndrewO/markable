require 'rake'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = 'markable'
  s.summary = "A module that adds Markaby functionality to any class"
  s.author = "Andrew O'Brien"
  s.email = "obrien.andrew@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.version = "1.0.0"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.require_path = 'lib'
  s.files = ["README", "Rakefile", "lib/markable.rb"]
  s.description = s.summary
  s.add_dependency('markaby', '>=0.5')
end

Rake::GemPackageTask.new(spec) do |p|
    p.gem_spec = spec
end