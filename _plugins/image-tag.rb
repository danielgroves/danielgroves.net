class ImageTag < Liquid::Tag
	ExtraClasses = /(\S+(\s+\S+){0,})/i

	def initialize(tag, attrs, tokens)
    super

		attributes_list = attrs.split(',')

		@src = ''
		@alt = ''

		attributes_list.each do |attribute|
			if attribute.include? 'src:'
				@src = attribute.sub(/^src: /, '')
			elsif attribute.include? 'alt:'
				@alt = attribute.sub(/^alt: /, '')
			end
		end
	end

	def render(context)
		"<img src=\"#{@src}\" alt=\"#{@alt}\" />"
	end
end

Liquid::Template.register_tag('img', ImageTag)
