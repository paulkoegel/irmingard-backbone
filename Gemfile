source 'https://rubygems.org'

gem 'rails', '~>3.2'
gem 'pg'
gem 'unicorn'
gem 'jquery-rails'
gem 'haml-rails'
gem 'settingslogic'
gem 'rails-backbone'
gem 'gon'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.6'
  gem 'compass-rails'
  gem 'compass-normalize'
  gem 'animation', '~> 0.1.alpha.3'
  gem 'haml_coffee_assets'
  gem 'execjs'
end

group :development do
  gem 'vendorer'
  gem 'heroku'
  gem 'quiet_assets'
  gem 'lograge'
end

group :development, :test do
  gem 'rspec-rails', '~>2.6'
  gem 'factory_girl_rails', '>=1.1.rc1'
  gem 'debugger', :platforms => :mri_19
  gem 'jasminerice'
  gem 'guard-jasmine'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem "fuubar", "~> 1.0.0"
  gem 'factory_girl_rails', '>=1.1.rc1', :require => false
  gem 'shoulda-matchers', '~> 1.2.0'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'capybara'
end

group :production do
end
