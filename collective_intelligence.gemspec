# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "collective_intelligence/version"

Gem::Specification.new do |s|
  s.name        = "collective_intelligence"
  s.version     = CollectiveIntelligence::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Cicero Oliveira"]
  s.email       = ["cicero@cicerooliveira.com"]
  s.homepage    = "http://www.CiceroOliveira.com"
  s.summary     = %q{Collective intellingence algorithms}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "collective_intelligence"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "rspec"
  s.add_development_dependency "cover_me", '>= 1.0.0.rc6'
end
