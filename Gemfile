source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "rspec", "~> 2.8.0"
  gem "rdoc", "~> 3.12"
  gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.8.3"
  gem "simplecov", "~> 0.5.4"
  gem "pry"
end

group :default do
  gem "octokit", "~> 0.6.5"
  gem "nokogiri", "~> 1.4.7"
  gem "sinatra", "~> 1.2.8"
  gem "rack", "~> 1.4.1"
end

# yo dawg, i herd u lieked jeweler
group :xzibit do
  # steal a page from bundler's gemspec:
  # add this directory as jeweler, in order to bundle exec jeweler and use the current working directory
  gem 'github-issues-pivotal-integration', :path => '.'
end