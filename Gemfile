source 'https://rubygems.org'
ruby '2.1.2'

# Basic rails gems
gem 'rails', '4.1.3'
gem 'pg'

# Profiler
#gem 'rack-mini-profiler'

#cookies for sidebar
gem 'jquery-cookie-rails'

# activity
gem 'public_activity'

# Style
gem 'sass-rails', '4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'slim-rails'

# add active class to links
gem 'active_link_to'

# Jquery + Jquery Turbolinks fix
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

# Styling
gem 'normalize-rails'
gem 'bourbon'
gem 'neat'

# Friendly IDs
gem 'friendly_id', '~> 5.0.0'

# Group and sum by date
gem 'groupdate'

# Charts JS in assets
gem 'morrisjs-rails'
gem 'raphael-rails'

# Delayed backgroundjob
gem 'sidekiq'

# Authentication
gem 'devise'
gem 'omniauth-facebook'
gem 'open_uri_redirections'

# Calculations
gem 'unitwise'

# Realtime messaging
gem 'pusher'

# Redis: Key/value based DB
gem 'redis-rails'

# Paperclip
gem 'paperclip', '~> 4.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',       group: :development
gem 'quiet_assets', group: :development

# Use Thin as the app server
gem 'thin'

# Heroku
gem 'rails_12factor', group: :production

# Better errors for sprockets
gem 'sprockets_better_errors'

# Testing purpose
group :development, :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'guard-rubocop'
  gem 'guard-bundler', require: false
  gem 'guard-livereload', require: false
  gem 'guard-brakeman'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'rails-perftest'
  gem 'yard' # RDOC comments written
  gem 'rails_best_practices', '~> 1.15.4'
  gem 'bullet'

  # Deployment to server
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-safe-deploy-to', '~> 1.1.1'
  gem 'capistrano-postgresql', '~> 3.0'
end
