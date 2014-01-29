source 'https://rubygems.org'
source 'http://gems.github.com'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Easy solution for os dependant dependancies 
gem 'os'
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

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
	gem 'rspec-rails'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'rugged', git: 'git://github.com/libgit2/rugged.git', branch: 'development', submodules: true
	if OS.mac? then
		puts 'OSX detected'
		gem 'growl_notify'
	end
end

