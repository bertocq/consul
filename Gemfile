source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.8'
# Use PostgreSQL
gem 'pg', '~> 0.20.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.2.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3.1'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Fix sprockets on the
gem 'sprockets', '~> 3.7.1'

gem 'devise', '~> 3.5.7'
gem 'devise_security_extension'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'omniauth'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'omniauth-google-oauth2', '~> 0.4.0'
gem 'omniauth-twitter'

gem 'acts-as-taggable-on'
gem 'acts_as_votable'
gem 'ancestry', '~> 2.2.2'
gem 'cancancan', '~> 1.16.0'
gem 'ckeditor', '~> 4.2.3'
gem 'daemons'
gem 'dalli'
gem 'delayed_job_active_record', '~> 4.1.0'
gem 'devise-async'
gem 'foundation-rails', '~> 6.2.4.0'
gem 'foundation_rails_helper', '~> 2.0.0'
gem 'initialjs-rails', '0.2.0.4'
gem 'invisible_captcha', '~> 0.9.2'
gem 'kaminari', '~> 1.0.1'
gem 'newrelic_rpm', '~> 4.1.0.333'
gem 'paranoia', '~> 2.3.1'
gem 'pg_search'
gem 'responders', '~> 2.4.0'
gem 'rinku', '~> 2.0.2', require: 'rails_rinku'
gem 'rollbar', '~> 2.14.1'
gem 'savon'
gem 'sitemap_generator', '~> 5.3.1'
gem 'social-share-button', '~> 0.10'
gem 'unicorn', '~> 5.3.0'
gem 'whenever', require: false

gem 'ahoy_matey', '~> 1.6.0'
gem 'groupdate', '~> 3.2.0' # group temporary data
gem 'tolk', '~> 2.0.0' # Web interface for translations

gem 'browser'
gem 'redcarpet', '~> 3.4.0'
gem 'rubyzip', '~> 1.2.0'
gem 'turnout', '~> 2.4.0'

gem 'paperclip'
gem 'rails-assets-markdown-it', source: 'https://rails-assets.org'

gem 'cocoon'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "bullet", '~> 5.5.1'
  gem 'capistrano', '~> 3.8.1',           require: false
  gem 'capistrano-bundler', '~> 1.2',  require: false
  gem "capistrano-rails", '~> 1.2.3',     require: false
  gem 'capistrano3-delayed-job', '~> 1.7.3'
  gem 'capybara', '~> 2.14.0'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem "faker", '~> 1.7.3'
  gem 'fuubar'
  gem 'i18n-tasks', '~> 0.9.15'
  gem 'knapsack'
  gem 'launchy'
  gem 'letter_opener_web', '~> 1.3.1'
  gem 'quiet_assets'
  gem 'rspec-rails', '~> 3.6'
  gem 'rubocop', '~> 0.49.1', require: false
  gem 'rvm1-capistrano3',              require: false
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'coveralls', '~> 0.8.21', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'poltergeist', '~> 1.15.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '3.3.0'
end

eval_gemfile './Gemfile_custom'
