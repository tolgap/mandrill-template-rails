# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'mandrill_rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'mandrill_rails'
  spec.version     = MandrillRails::VERSION
  spec.authors     = ['Tolga Paksoy']
  spec.email       = ['tolga@paramander.com']
  spec.homepage    = 'https://github.com/tolgap/mandrill_rails'
  spec.summary     = 'Rails support for Mandrill Templates'
  spec.description = "Send E-mails by leveraging Mandrill's templates. Supports all ActionMailer options."
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'mandrill-api', '~> 1.0.53'
  spec.add_dependency 'rails', '>= 5.0.0', '< 7.0.0'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
end
