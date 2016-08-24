require 'HTTParty'
require 'Nokogiri'

class FacebookProfileScraper
  def initialize(facebook_profile)
    begin
      # Download page (GET REQEUST)
      @page = HTTParty.get(facebook_profile)
      # Parse the page with Nokogiri
      @parsed_page = Nokogiri::HTML(@page)
    rescue
    end
  end
  def name
    begin
      # Parse full name from profile
      @parsed_page.css('#fb-timeline-cover-name').text
    rescue
    end
  end
  def picture
    begin
      # Parse profile picture from profile
      @parsed_page.css('img.profilePic.img').attr('src')
    rescue
    end
  end
  def city
    begin
      # Parse first city from profile
      @parsed_page.css('#pagelet_hometown span._50f5._50f7')[0].css('a').text
    rescue
    end
  end
  def about
    begin
      # Parse "about" from profile
      @parsed_page.css('#pagelet_bio span._c24._50f4')[0].text
    rescue
    end
  end
  def quote
    begin
      # Parse "quote" from profile
      @parsed_page.css('#pagelet_quotes span._c24._50f4')[0].text
    rescue
    end
  end
end