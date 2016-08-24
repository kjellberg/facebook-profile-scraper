require_relative "lib/facebook-profile-scraper"

profile = FacebookProfileScraper.new('https://www.facebook.com/zuck') # Download profile
puts profile.picture if profile.picture # => "Palo Alto, California"