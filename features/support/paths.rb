# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def path_to(page_name)
      case page_name
  
      when /^the home\s?page$/ then '/'

      when /^the show page for "(.+)"$/ then "/video/#{Video.find_by(yt_video_id: $1).id}"
      
      when /^the description page for "(.+)"$/ then "/video/#{Video.find_by(yt_video_id: $1).id}/describe"
  

      # For users
      when /^the Users index page$/ then '/user'
      when /^the new user page$/ then '/user/new'
      when /^the user login page$/ then '/user/login'

      # For videos
      # Since we don't store the YouTube id, we will need to GET the yt_video_id
      # and then pass the yt_video_id to /video/yt_video_id
      when /^the view page for the YouTube link "(.*)"$/ then "/video/#{$1}"
        
      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
      end
    end
  end
  
  World(NavigationHelpers)
  
  