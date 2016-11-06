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

  def work_experience
    work_experience = []
    begin
      @parsed_page.css('div[data-pnref=work] .fbEditProfileViewExperience').each do |div| 
        work = {}
        work[:name] = ''
        work[:meta_data] = ''
        work[:name] = div.css('a').text
        div.css('div.fsm').each do |work_meta_data_object| 
          work_meta_data = work_meta_data_object.text
          if work_meta_data.include?(' · ')
            work[:meta_data] = work_meta_data.split(' · ')
          else
            work[:meta_data] = [work_meta_data]
          end
        end
        work_experience << work
      end
    rescue
    end
    work_experience
  end

  def education
    education = []
    begin
      @parsed_page.css('div[data-pnref=edu] .fbEditProfileViewExperience').each do |div| 
        school = {}
        school[:name] = ''
        school[:meta_data] = ''
        school[:name] = div.css('a').text
        div.css('div.fsm').each do |school_meta_data_object| 
          byebug
          school_meta_data = school_meta_data_object.text
          if school_meta_data.include?(' · ')
            school[:meta_data] = school_meta_data.split(' · ')
          else
            school[:meta_data] = [school_meta_data]
          end
        end
        education << school
      end
    rescue
    end
    education
  end

  # def favorites
  # end

  # def favorite_athlete
  # end

  # def favorite_sports_teams
  # end

  # def favorite_movies
  # end

  # def favorite_games
  # end

  # def favorite_television
  # end

  # def favorite_interests
  # end

  # def favorite_music
  # end

  # def favorite_activities
  # end

  # def favorite_books
  # end
end
