require 'HTTParty'
require 'Nokogiri'

class FacebookProfileScraper
  def initialize(facebook_profile)
    # Download page (GET REQEUST)
    @page = HTTParty.get(facebook_profile)
    # Parse the page with Nokogiri
    @parsed_page = Nokogiri::HTML(@page)
  end
  def city
    # Parse first city from profile
    @parsed_page.css('span._50f5._50f7')[0].css('a').text
  end
end