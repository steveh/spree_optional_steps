# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "spree_optional_steps"
  s.version     = "1.0.0"
  s.summary     = "Allows for optional checkout steps"
  s.description = "Allows for optional checkout steps"

  s.author   = "Localist"
  s.email    = "support@localist.co.nz"
  s.homepage = "http://www.localist.co.nz"

  #s.files        = `git ls-files`.split("\n")
  #s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "spree_core", "~> 1.1.0"
end
