# Facebook Profile Scraper


## Example
```ruby
# Get city from Facebook profile
profile = FacebookProfileScraper.new('https://www.facebook.com/zuck') # Download profile
profile.name # => "Mark Zuckerberg"
profile.picture # => "https://scontent-cdg2-1.xx.fbcdn.net/v/t1.0-1/p160x160/12208495_10102454385528521_4749095086285673716_n.jpg?oh=7fb3531d093fccaf14985e3f99a8ac15&oe=58418403"
profile.city # => "Palo Alto, California"
profile.about # => "I'm trying to make the world a more open place."
profile.quote # => "Fortune favors the bold...." 
```
