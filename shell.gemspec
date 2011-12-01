# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shell_utils/version"

Gem::Specification.new do |s|
  s.name        = "shell"
  s.version     = ShellUtils::VERSION
  s.authors     = ["Josh Hull"]
  s.email       = ["joshbuddy@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Some common shell utils}
  s.description = %q{Some common shell utils.}

  s.rubyforge_project = "shell_utils"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
end
