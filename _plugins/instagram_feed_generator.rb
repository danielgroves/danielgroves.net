require 'instagram'
require 'time'

module Jekyll
    class InstagramFeed < Liquid::Tag
        def initialize(tag_name, tag, tokens)
            super

            self.get_settings

            Instagram.configure do |config|
                config.client_id = @client_id
                config.client_secret = @client_secret
            end

            @feed = Array.new

            if @client_id && @client_secret
              instagram = Instagram.user_recent_media(@user_id, {:min_timestamp => @min_timestamp, :max_timestamp => @max_timestamp, :count => @count})

              print "Found #{instagram.length} images. "
              instagram.each do |instagram|
                  if (tag.nil? || tag.empty?) || (instagram.tags.include? tag.strip)
                      @feed.push(instagram)
                  end
              end
              print "Filtered #{@feed.length} images on tag '#{tag}'"
            else
              print "No Instagram client id and/or secret given. Please refer to the docs, the instragram feed will not be generated."
            end
        end

        def get_settings
            instagram_config = Jekyll.configuration({})['instagram']

            @client_id = instagram_config['client_id'] ? instagram_config['client_id'] : ENV['INST_CLIENT_ID']
            @client_secret = instagram_config['client_secret'] ? instagram_config['client_secret'] : ENV['INST_CLIENT_SECRET']
            @user_id = instagram_config['user_id']
            @min_timestamp = instagram_config['min_timestamp'].to_i
            @max_timestamp = instagram_config['max_timestamp'].to_i
            @count = instagram_config['count'].nil? ? 1000 : instagram_config['count']
        end

        def render(context)
            out = ''
            out += "<p class=\"easyread\">There are #{365 - @feed.length} images left to upload.</p>"

            if Time.now.year < 2015
                out += '<p class="easyread">This challenge has not yet started. It will begin at midnight on the 1st January 2014.</p>'
            else
                @feed.each do |photo|
                    out += "<figure>\n"
                    out += "    <a href=\"#{photo.link}\" title=\"View on Instagram\">\n"
                    out += "        <img src=\"#{photo.images.low_resolution.url}\" width=\"#{photo.images.low_resolution.url}\" height=\"#{photo.images.low_resolution.url}\" />\n"
                    out += "    </a>\n"
                    out += "    <figcaption>\n"

                    if photo.caption
                        out += "        <span class=\"caption\">#{photo.caption.text}</span>\n"
                    else
                        out += "        <span class=\"caption\"></span>\n"
                    end

                    out += "        <span class=\"date\">Uploaded on #{Time.at(photo.created_time.to_i).strftime('%d %B %Y')}</span>\n"
                    out += "        <a href=\"#{photo.link}\" title=\"View this image on Instagram\">View on Instagram &rarr;</a>"
                    out += "    </figcaption>\n"
                    out += "</figure>\n"
                end
            end

            return out
        end
    end
end


Liquid::Template.register_tag('instagramfeed', Jekyll::InstagramFeed)
