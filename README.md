# Facebook Profile Scraper
A simple class to fetch profile data from Facebook accounts. This is my first GEM so please contribute if you know how to make it better :) 

## Installation
Install 'Facebook Profile Scraper' from RubyGems:
```
$ gem install 'facebook-profile-scraper'
```
Or include it in your project's Gemfile with Bundler:
```ruby
gem 'facebook-profile-scraper', '~> 1.0'
```

## Example
```ruby
profile = FacebookProfileScraper.new('https://www.facebook.com/zuck') # Download profile
profile.name # => "Mark Zuckerberg"
profile.picture # => "https://scontent-cdg2-1.xx.fbcdn.net/...3716_n.jpg?oh=7fb3531d09...e=58418403"
profile.city # => "Palo Alto, California"
profile.about # => "I'm trying to make the world a more open place."
profile.quote # => "Fortune favors the bold...." 
```
