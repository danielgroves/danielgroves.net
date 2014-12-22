require 'instagram'

module Jekyll
    class InstagramFeed < Liquid::Tag
        def initialize(tag_name, tag, tokens)
            super

            self.get_settings

            Instagram.configure do |config|
                config.client_id = @client_id
                config.client_secret = @client_secret
            end

            instagram = Instagram.user_recent_media(@user_id, {:min_timestamp => 1416441600})
            print "Found #{instagram.length} images. "

            @feed = Array.new
            instagram.each do |instagram|
                if (tag.nil? || tag.empty?) || (instagram.tags.include? tag.strip)
                    @feed.push(instagram)
                end
            end

          print "Filtered #{@feed.length} images on tag '#{tag}'"
        end

        def get_settings
            instagram_config = Jekyll.configuration({})['instagram']

            @client_id = !instagram_config.nil? && instagram_config['client_id'] ? instagram_config['client_id'] : ENV['INST_CLIENT_ID']
            @client_secret = !instagram_config.nil? && instagram_config['client_secret'] ? instagram_config['client_secret'] : ENV['INST_CLIENT_SECRET']
            @user_id = !instagram_config.nil? && instagram_config['user_id'] ? instagram_config['user_id'] : ENV['INST_USER_ID']
        end

        def render(context)
            out = ''

            @feed.each do |photo|
                out += "<figure>\n"
                out += "    <img src=\"#{photo.images.standard_resolution.url}\" width=\"#{photo.images.standard_resolution.url}\" height=\"#{photo.images.standard_resolution.url}\" />\n"

                if photo.caption
                    out += "    <figcaption>#{photo.caption.text}</figcaption>\n"
                end

                out += "</figure>\n"
            end

            return out
        end
    end
end


Liquid::Template.register_tag('instagramfeed', Jekyll::InstagramFeed)
