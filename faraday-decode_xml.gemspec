# frozen_string_literal: true

require_relative 'lib/faraday/decode_xml/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-decode_xml'
  spec.version = Faraday::DecodeXML::VERSION
  spec.authors = ['Spencer Oberstadt']
  spec.email = ['spencer.oberstadt@anedot.com']

  spec.summary = 'Faraday middleware for decoding XML requests'
  spec.description = <<~DESC
    Faraday middleware for decoding XML requests.
  DESC
  spec.license = 'MIT'

  github_uri = "https://github.com/soberstadt/#{spec.name}"

  spec.homepage = github_uri

  spec.metadata = {
    'bug_tracker_uri' => "#{github_uri}/issues",
    'changelog_uri' => "#{github_uri}/blob/v#{spec.version}/CHANGELOG.md",
    'documentation_uri' => "http://www.rubydoc.info/gems/#{spec.name}/#{spec.version}",
    'homepage_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => github_uri,
    'wiki_uri' => "#{github_uri}/wiki"
  }

  spec.files = Dir['lib/**/*', 'README.md', 'LICENSE.md', 'CHANGELOG.md']

  spec.required_ruby_version = '>= 2.5', '< 4'

  spec.add_runtime_dependency 'faraday', '< 3.0'
  spec.add_runtime_dependency 'multi_xml', '< 1.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.21.0'

  spec.add_development_dependency 'rubocop', '~> 1.25.1'
  spec.add_development_dependency 'rubocop-packaging', '~> 0.5.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
end
