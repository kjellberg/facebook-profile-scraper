require 'open-uri'
require 'nokogiri'

class FacebookProfileScraper

  ELEMENT_CONFIG = {
    name: {
      selector: '#fb-timeline-cover-name',
      value: -> (element) { element.text }
    },
    picture_url: {
      selector: 'img.profilePic.img',
      value: -> (element) { element.attr('src') }
    },
    city: {
      selector: '#pagelet_hometown span._50f5._50f7',
      value: -> (element) { element.css('a').text }
    },
    about: {
      selector: '#pagelet_bio span._c24._50f4',
      value: -> (element) { element.text }
    },
    quote: {
      selector: '#pagelet_quotes span._c24._50f4',
      value: -> (element) { element.text }
    }
  }

  def initialize(facebook_profile_url)
    begin
      response = open(facebook_profile_url)
      @parsed_page = Nokogiri::HTML(response.read)
    rescue OpenURI::HTTPError
      puts "Couldn't get profile: #{facebook_profile_url}"
    end

    self
  end

  # def method_missing(method, *arguments, &block)
  def method_missing(method)
    element_config = ELEMENT_CONFIG[method.to_sym]

    # Nokogiri always return an array of elements
    element = @parsed_page.css(element_config[:selector]).first

    # Return if not found
    return unless element

    # Get value
    value = element_config[:value].call(element)

    # Don't allow empty string
    value.empty? ? nil : value
  end

end
