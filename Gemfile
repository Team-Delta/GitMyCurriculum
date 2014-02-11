source 'https://rubygems.org'
source 'http://gems.github.com'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Faster debug for Rails
gem 'debugger'

# Easy solution for os dependant dependancies 
require 'os'

# User authentication
gem 'devise'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Search with Sunspot Solr
gem 'sunspot_solr'
gem 'sunspot_rails'
gem 'sunspot_test'

# Progress bar for prolonged activities in the terminal
gem 'progress_bar'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
    # used for development seeding of database
    gem 'seed-fu', github: 'mbleigh/seed-fu'

    # used for test case database
    gem 'factory_girl_rails'

    # testing framework for rails
	gem 'rspec-rails'

    # Simulates the user in test cases
	gem 'capybara'

    # automated test running on development machines
	gem 'guard-rspec'

    # ruby bindings for git framework
	gem 'rugged', git: 'git://github.com/libgit2/rugged.git', branch: 'development', submodules: true

	if OS.mac? then
        # notifications for guard on a mac
		puts 'OSX detected'
		gem 'growl_notify'
	end
end

