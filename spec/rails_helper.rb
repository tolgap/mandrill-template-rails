# frozen_string_literal: true

require_relative 'dummy/config/environment.rb'

ENV['RAILS_ENV'] ||= 'test'

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'spec_helper'
require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.filter_rails_from_backtrace!
end
