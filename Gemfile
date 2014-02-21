source 'https://rubygems.org'
source 'http://gems.github.com'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# User authentication
gem 'devise'

# Use mysql as the database for Active Record
gem 'mysql2'

# Search with Sunspot Solr
gem 'sunspot_solr'
gem 'sunspot_rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :development do
    # automated test running on development machines
    gem 'guard-rspec'

    # Progress bar for prolonged activities in the terminal
    gem 'progress_bar'

    # used for development seeding of database
    gem 'seed-fu', github: 'mbleigh/seed-fu'

    # Easy solution for os dependant dependancies 
    require 'os'

    if OS.mac? then
        # notifications for guard on a mac
        puts 'OSX detected'
        gem 'growl_notify'
    end
end

group :development, :production do
    # ruby bindings for git framework
    gem 'rugged', git: 'git://github.com/libgit2/rugged.git', branch: 'development', submodules: true

    # Use CoffeeScript for .js.coffee assets and views
    gem 'coffee-rails', '~> 4.0.0'

    # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
    gem 'jbuilder', '~> 1.2'
end

group :test do
    # Ruby and Rails formatter. To install on sublime run package control and search rubocop and install it as well.
    gem 'rubocop'

    # Simulates the user in test cases
    gem 'capybara'

    # used for test case database
    gem 'factory_girl_rails'

    # testing framework for rails
    gem 'rspec-rails'

    # Search with Sunspot Solr
    gem 'sunspot_test'
end

group :production do
    # Use Uglifier as compressor for JavaScript assets
    gem 'uglifier', '>= 1.3.0'
end

group :ci do
    gem 'coveralls'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end