source 'https://rubygems.org'
source 'http://gems.github.com'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# User authentication
gem 'devise'
gem 'cancan'

# Use mysql as the database for Active Record
gem 'mysql2'

# Search with Sunspot Solr
gem 'sunspot_solr'
gem 'sunspot_rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'sprockets', '2.11.0'
gem 'sass-rails', '>= 4.0.0'
gem 'bootstrap-sass', '~> 3.1.1'

# make diffs look nicer
gem 'diffy'

# passing data to javascript
gem 'gon'

# Unzipping files
gem 'rubyzip'

# Progress bar for prolonged activities in the terminal
gem 'progress_bar'

# ruby bindings for git framework
gem 'git'

group :development do
  # automated test running on development machines
  gem 'guard-rspec'

  # used for development seeding of database
  gem 'seed-fu', github: 'mbleigh/seed-fu'

  # looks for n + 1 queries
  gem 'bullet'

  # gives a better stack trace for errors
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :production do

  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 1.2'
end

group :test, :development do

  # Ruby and Rails formatter. To install on sublime run package control and search rubocop and install it as well.
  gem 'rubocop', '~>0.20.1'

  # Simulates the user in test cases
  gem 'capybara'

  # used for test case database
  gem 'factory_girl_rails'

  # testing framework for rails
  gem 'rspec-rails'

  # Search with Sunspot Solr
  gem 'sunspot_test'

  # test documentation
  gem 'inch'

  # javascript driver for capybara
  gem 'poltergeist'

end

group :production do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end

group :ci do
  gem 'coveralls'
  gem 'simplecov', '~> 0.7.1', :require => false, :group => :test
  gem 'codeclimate-test-reporter'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
