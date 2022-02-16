# -*- encoding: utf-8 -*-
# stub: razor_csv_reader 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "razor_csv_reader".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "TODO: Set to 'http://mygemserver.com'" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Max Hollmann".freeze]
  s.bindir = "exe".freeze
  s.date = "2022-02-16"
  s.email = ["max.hollmann@toptal.com".freeze]
  s.files = [".gitignore".freeze, ".rspec".freeze, ".ruby-version".freeze, ".travis.yml".freeze, "Gemfile".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/csv_reader.rb".freeze, "lib/csv_reader/config.rb".freeze, "lib/csv_reader/field.rb".freeze, "lib/csv_reader/reader.rb".freeze, "lib/csv_reader/row.rb".freeze, "lib/csv_reader/version.rb".freeze, "lib/razor_csv_reader.rb".freeze, "razor_csv_reader.gemspec".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "CSV library.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
  end
end
