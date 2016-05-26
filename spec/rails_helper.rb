require 'spec_helper'
require 'capybara/poltergeist'
require 'support/authentication_helper'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include AuthenticationHelper
end
