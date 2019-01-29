source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.1'
gem 'rails', '~> 5.1.1'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise', '~> 4.5.0'
gem 'simple_form', '~> 4.1.0'
gem 'cancancan', '~> 2.3.0'
gem 'select2-rails', '~> 4.0.3'
gem 'cocoon', '~> 1.2.12'
gem 'httparty', '~> 0.16.3'
gem 'nokogiri', '~> 1.8.5'
gem 'oauth2', '~> 1.4.1'
gem 'redis', '~> 4.0.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver', '~> 3.141.0'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap', '>= 4.1.2'
gem 'haml-rails', '~> 1.0.0'
gem 'high_voltage', '~> 3.1.0'
gem 'jquery-rails', '~> 4.3.3'
gem 'mysql2', '~> 0.3.18'
group :development do
  gem 'better_errors', '~> 2.5.0'
  gem 'html2haml', '~> 2.2.0'
  gem 'rails_layout', '~> 1.0.42'
  gem 'spring-commands-rspec', '~> 1.0.4'
end
group :development, :test do
  gem 'factory_girl_rails', '~> 4.9.0'
  gem 'faker', '~> 1.9.1'
  gem 'rspec-rails', '~> 3.8.1'
end
group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'launchy', '~> 2.4.3'
end
