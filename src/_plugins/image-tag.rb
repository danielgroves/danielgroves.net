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
        @src = attribute.sub(/^src: /, '') + '.jpg'
      elsif attribute.include? 'wm:'
        @watermark = (attribute.sub(/^wm: /, '') == 'true')
      elsif attribute.include? 'alt:'
        @alt = attribute.sub(/^alt: /, '')
      end
    end

    @config = Jekyll.configuration({})['imgix']
  end

  def render(context)
    img  = "<picture>"
    img += "  <source srcset=\"#{build_image_url(@src, 1500)}\" media=\"(min-width: 1300px)\">"
    img += "  <source srcset=\"#{build_image_url(@src, 1200)}\" media=\"(min-width: 1100px)\">"
    img += "  <source srcset=\"#{build_image_url(@src, 1000)}\" media=\"(min-width: 900px)\">"
    img += "  <source srcset=\"#{build_image_url(@src, 800)}\" media=\"(min-width: 700px)\">"
    img += "  <source srcset=\"#{build_image_url(@src, 600)}\" media=\"(min-width: 500px)\">"
    img += "  <source srcset=\"#{build_image_url(@src, 400)}\" media=\"(min-width: 300px)\">"
    img += "  <source srcset=\"#{build_image_url(@src, 200)}\" media=\"(min-width: 0px)\">"
    img += "  <img src=\"#{build_image_url(@src, 400)}\">"
    img += "</picture>"
  end

  def build_image_url(image, width, watermark=true)
    client = Imgix::Client.new(host: @config['urls'], secure_url_token: ENV['IMGIX_TOKEN'])
    path = client.path(image)
    path.width = width
    path.fit = 'crop'

    if (watermark)
      path.mark = @config['mark_url']
      path.markalign = 'bottom,left'
      path.markpad = 25
      path.markw = 200
    end

    path.to_url
  end

end

Liquid::Template.register_tag('img', ImageTag)
