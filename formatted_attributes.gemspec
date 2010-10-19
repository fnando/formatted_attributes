# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "formatted_attributes/version"

Gem::Specification.new do |s|
  s.name        = "formatted_attributes"
  s.version     = FormattedAttributes::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/formatted_attributes"
  s.summary     = "Add formatted methods for ActiveRecord attributes"
  s.description = "Sometimes you need to expose a helper method that will convert its value before saving it to the database. This gem will add `formatted_` suffix to the attributes you specify."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord"
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "ruby-debug19"
end
