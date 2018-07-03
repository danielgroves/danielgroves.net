class FigCaptionBlock < Liquid::Block
	ExtraClasses = /(\S+(\s+\S+){0,})/i

	def initialize(tag, text, tokens)
    super
	end

	def render(context)
    contents = super.strip
		site = context.registers[:site]
		converter = site.find_converter_instance ::Jekyll::Converters::Markdown
		output = converter.convert contents

		caption = output.sub(/^<p>/, '')
		caption = caption.sub(/<\/p>$/, '')

		"<figcaption>#{caption}</figcaption>"
	end
end

Liquid::Template.register_tag('figcaption', FigCaptionBlock)
