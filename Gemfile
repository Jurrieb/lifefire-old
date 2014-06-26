source 'https://rubygems.org'
ruby '2.1.2'

# Basic rails gems
gem 'rails', '4.1.1'
gem 'pg'
gem 'sass-rails', '4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'slim-rails'
gem 'jquery-rails'
gem 'turbolinks'

# Jquery ready fix
gem 'jquery-turbolinks'

# Styling
gem 'normalize-rails'
gem 'bourbon'
gem 'neat'

# Charts
gem 'chartkick'
gem 'groupdate'

# Facebook gem
gem 'koala', '~> 1.10.0rc'

# Authentication
gem 'devise'
gem 'omniauth-facebook'
gem 'open_uri_redirections'

# Calculations
gem 'unitwise'

# Paperclip
gem 'paperclip', '~> 4.1'
gem 'aws-sdk'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',       group: :development
gem 'quiet_assets', group: :development

# Use Thin as the app server (better performance Heroku)
gem 'thin'

# Heroku
gem 'rails_12factor', group: :production

# Better errors for sprockets
gem 'sprockets_better_errors'

# Testing purpose
group :development, :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false, :group => :test
  gem 'rubocop', require: false
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'guard-rubocop'
  gem 'guard-bundler', require: false
  gem 'guard-livereload', require: false
  gem 'guard-brakeman'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
end
