ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  #including FactoryBot
  include FactoryBot::Syntax::Methods
  FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
  # FactoryBot.find_definitions
  

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  

end
