require 'spec_helper'
require 'capybara/poltergeist'
require 'support/authentication_helper'
require 'support/capybara_helper'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include AuthenticationHelper
  config.include CapybaraHelper
end
