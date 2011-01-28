# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enumerated/version"

Gem::Specification.new do |s|
  s.name        = "enumerated"
  s.version     = Enumerated::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michal Orman"]
  s.email       = ["michal.orman@gmail.com"]
  s.homepage    = "https://github.com/michalorman/enumerated"
  s.summary     = %q{Yet another enumeration gem for ActiveRecord}
  s.description = %q{Goal of the Enumerated gem is to provide support to use enumerations on selection/drop down lists.}

  s.rubyforge_project = "enumerated"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rcov"
  s.add_development_dependency "activesupport", ["~> 3.0.0"]
  s.add_development_dependency "activerecord", ["~> 3.0.0"]
  s.add_development_dependency "sqlite3-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
