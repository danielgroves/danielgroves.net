class ImageTag < Liquid::Tag
  ExtraClasses = /(\S+(\s+\S+){0,})/i

  def initialize(tag, attrs, tokens)
    super

    attributes_list = attrs.split(',')

    @src = ''
    @watermark = true
    @alt = ''

    attributes_list.each do |attribute|
      if attribute.include? 'src:'
        @src = attribute.sub(/^src: /, '')
      elsif attribute.include? 'wm:'
        @watermark = (attribute.sub(/^wm: /, '') == 'true')
      elsif attribute.include? 'alt:'
        @alt = attribute.sub(/^alt: /, '')
      end
    end

    @config = Jekyll.configuration({})['imgix']

    if @watermark
      @url = "#{@config['main_images']}#{@src}"
    else
      @url = "#{@config['metadata_images']}#{@src}"
    end
  end

  def render(context)
    img = "<img data-src=\"#{@url}.jpg\" alt=\"#{@alt}\" class=\"imgix-fluid\"/>"
    img+= "<noscript><img src=\"#{@url}.jpg\" alt=\"#{@alt}\" /></noscript>"
  end
end

Liquid::Template.register_tag('img', ImageTag)
