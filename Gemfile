source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.9'



# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.6'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Switch to postgres for a database
gem 'pg', '0.21.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby



# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.16'
gem 'nokogiri', '1.13.3'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.10.2', require: false  # '1.4.6'

# For serializing models to json for the API
gem 'fast_jsonapi', '1.5'

# Other gems
gem 'validates_timeliness', '5.0.0'
gem 'time_date_helpers', '0.0.4'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'cancancan', '3.1.0'   # '3.1.0'

# View gems
gem 'will_paginate'
gem 'simple_form', '5.1.0'
gem 'materialize-form', git: 'https://github.com/cmu-is-projects/materialize-form.git'
gem 'best_in_place', '3.0.3'
gem 'materialize-sass', '1.0.0'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # gem 'better_errors'
  # gem 'binding_of_caller'
  # gem 'meta_request'
  gem 'capistrano',                 '2.15.5'
  # gem 'capistrano-rails',           '1.4.0'
  # gem 'capistrano-rbenv',           '2.1.4 '
  # gem 'capistrano-passenger',       '0.2.0'
  gem 'hirb', '0.7.3'
  gem 'faker', '2.16.0'
  gem 'populator', '1.0.0'
  gem 'factory_bot_rails', '6.2.0'
  gem 'simplecov', '0.21.2'
  gem 'shoulda', '4.0.0'
  gem 'shoulda-matchers', '4.5.1'
  gem 'rails-controller-testing', '1.0.5'
  gem 'cucumber', '5.3.0'
  gem 'cucumber-rails', '2.2.0', require: false
  gem 'database_cleaner', '2.0.1'
  gem 'launchy', '2.5.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '3.7.0'
  gem 'listen', '3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.1.1'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  # Using minitest
  gem 'minitest-rails', '3.0.0'
  gem 'minitest-reporters', '1.1.19'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '3.35.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
