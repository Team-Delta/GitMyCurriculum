source 'https://rubygems.org'


gem 'rails', '4.0.1'
gem 'mysql', '~> 2.9.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

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
	gem 'turn'
	gem 'rspec-rails'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'rugged', git: 'git://github.com/libgit2/rugged.git', branch: 'development', submodules: true
	gem 'mysql2'
end
