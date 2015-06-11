module Jekyll
  class MapboxEmbed < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
      @config = Jekyll.configuration({})['mapbox']
    end
    
    def build_url()
      url = "https://a.tiles.mapbox.com/v4/#{@config['id_prefix']}#{@text}/"
      
      if (@config['options']['zoompan'])
        url += "zoompan,"
      end
      
      if (@config['options']['zoomwheel'])
        url += "zoomwheel,"
      end
      
      if (@config['options']['geocoder'])
        url += "geocoder,"
      end
      
      if (@config['options']['link'])
        url += "share,"
      end
      
      url = url.chop
      
      url += ".html?access_token=#{@config['access_token']}"
      
      url 
    end
    
    def render(context)
      "<iframe width='100%' height='800px' frameBorder='0' src='#{build_url()}'></iframe>"
    end
  end
end

Liquid::Template.register_tag('mapbox', Jekyll::MapboxEmbed)