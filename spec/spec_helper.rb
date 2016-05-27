require 'rubygems'
require 'codeclimate-test-reporter'
require 'capybara/poltergeist'

CodeClimate::TestReporter.start

ENV['RAILS_ENV'] ||= 'test'

require 'rails/application'

# Loading more in this block will cause your tests to run faster. However,
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  config.use_transactional_examples = false
  config.expose_current_running_example_as :example
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:transaction)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = if example.metadata[:js]
                                 :truncation
                               else
                                 :transaction
                               end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Clear ActionMailer deliveries after each spec.
  config.after(:each) { ActionMailer::Base.deliveries.clear }
end

Capybara.register_driver :poltergeist do |app|
  options = {
    phantomjs: Phantomjs.path,
    timeout: 60,
    js_errors: false,
    poltergeist_extensions: [Rails.root.join('spec/support/ga_events_extension.js')]
  }
  Capybara::Poltergeist::Driver.new app, options
end
Capybara.javascript_driver = :poltergeist