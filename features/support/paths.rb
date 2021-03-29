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
  
      when /^the Video Requests page$/ then '/video_requests'
        
      # For users
      when /^the Users index page$/ then '/user'
      when /^my dashboard$/ then '/dashboard'

      # For videos
      when /^the view page for the video id "(.*)"$/ then "/video/#{$1}"
      when /^the upvote request page for the video request id "(.*)"$/ then "/video_requests/#{$1}"

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
  
  