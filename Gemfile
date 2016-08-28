source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'pg'
gem 'bcrypt-ruby', '3.1.2'
gem 'active_model_serializers', '~> 0.10.0.rc2'

gem 'rack-cors'
gem 'responders'
gem 'rails-api'
gem 'dotenv-rails'

gem 'doorkeeper', '~> 3.0.1'
gem 'omniauth-oauth2'
gem 'omniauth-steam'
gem 'figaro'
gem 'ahoy_matey'
gem 'openid_connect'
gem 'therubyracer', platforms: :ruby
gem 'redis', '~>3.2'
gem 'coveralls', require: false
gem 'kaminari'
gem 'paperclip'
gem 'aws-sdk', '~> 2.3'
gem 'sidekiq'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'
gem 'whenever', :require => false

group :development, :test do
  gem 'pry'
  gem "rails-erd"
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'letter_opener'
end

group :test do 
  gem 'database_cleaner'
  gem 'simplecov', :require => false
  gem 'shoulda-matchers'
  gem 'shoulda'
end

group :production do 
  gem 'rails_12factor'
  gem 'unicorn'
  gem 'newrelic_rpm'
end
