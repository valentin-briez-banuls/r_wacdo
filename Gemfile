source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.8"

gem "rails", "~> 8.0.2"

gem "sprockets-rails"

# DB
gem "pg", "~> 1.1"

# Web server
gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"
gem "stimulus-rails"

gem "jbuilder"

# Authentication
gem "devise"

# Advanced search
gem 'ransack'

# CSS framework
gem "bootstrap", "~> 5.3.0"

gem "sassc-rails"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false


gem "rspec-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rubocop', require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
