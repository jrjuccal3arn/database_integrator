$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "database_integrator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "database_integrator"
  s.version     = DatabaseIntegrator::VERSION
  s.authors     = ["marcio juinor"]
  s.email       = ["marciojunior_eu@yahoo.com.br"]
  #s.homepage    = "TODO"
  #s.summary     = "TODO: Summary of DatabaseIntegrator."
  #s.description = "TODO: Description of DatabaseIntegrator."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  s.add_dependency "spreadsheet", "~> 0.6.5.9"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "remotipart", "~> 1.0.2"
end
