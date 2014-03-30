RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    Capybara.current_driver = :selenium 
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    Capybara.current_driver = :selenium if options[:js]
  end
 
  config.after(:each) do
    Capybara.use_default_driver if options[:js]
  end

end