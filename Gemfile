source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '~> 4.1.1'
gem 'rails', '= 5.2.4.6'
# Use postgresql as the database for Active Record
gem 'pg'#, '~> 0.18.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
#gem 'therubyracer',  platforms: :ruby
gem 'mini_racer'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-datatables-rails'
gem 'jquerycsv-rails'
gem 'select2-rails'

gem 'd3-rails', '3.4.11'

gem 'activestorage', '5.2.4.6'


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc
gem "json", ">= 2.3.0"

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
#gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'#, group: :production

# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# File Storage
gem 'paperclip', '~> 6.0'
gem 'aws-sdk'
gem 'aws-sdk-dynamodb'
gem 'aws-sdk-s3', require: false

# Authentication
gem 'devise'
gem 'devise_cas_authenticatable'

# Authorization
gem 'pundit'

# Roles
gem 'royce'

# Markup
gem 'haml-rails'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]


#Rails Admin
gem 'rails_admin'
# gem 'rails_admin_import'

#Tagging
gem 'acts-as-taggable-on'

group :production do
  gem 'exception_notification'
end

group :development, :test do
  gem 'railroady'
  gem 'metric_fu'
  gem 'ruby-debug-ide'
  gem 'debase'
end

gem 'mimemagic', ">= 0.3.6"
gem 'nio4r', '>= 2.5.7'

gem "nokogiri", ">= 1.11.4"
gem "addressable", ">= 2.8.0"
gem "puma", ">= 6.0.0"
gem "image_processing", ">= 1.2"
gem 'pry-rails', group: :development
gem 'rack-cas'
