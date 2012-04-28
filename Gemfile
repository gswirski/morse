source 'http://rubygems.org'

gem 'rails', '3.2.0'

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'spork-rails'
  gem 'spork-testunit'
end

gem 'devise'
gem 'pygmentize'
gem 'kaminari'
gem 'cancan'
gem 'responders'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
