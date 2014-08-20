#
# Based on RealJenius.com cat_and_tag_generator
# https://github.com/realjenius/realjenius.com/blob/master/_plugins/cat_and_tag_generator.rb
#

module Jekyll

  class CatsAndTags < Generator

    safe true

    def generate(site)
      site.categories.each do |category|
        build_subpages(site, "category", category)
      end

      site.tags.each do |tag|
        build_subpages(site, "tag", tag)
      end
    end

    def build_subpages(site, type, posts)
      posts[1] = posts[1].sort_by { |p| -p.date.to_f }
      paginate(site, type, posts)
    end

    def paginate(site, type, posts)
      pages = Jekyll::Paginate::Pager.calculate_pages(posts[1], site.config['paginate'].to_i)
      (1..pages).each do |num_page|
        pager = Jekyll::Paginate::Pager.new(site, num_page, posts[1], pages)
        path = "/#{posts[0]}"
        if num_page > 1
          path = path + "/#{num_page}"
        end

        newpage = GroupSubPage.new(site, site.source, path, type, posts[0])
        newpage.pager = pager
        site.pages << newpage

      end
    end
  end

  class GroupSubPage < Page
    def initialize(site, base, dir, type, val)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)

      if File.exist?(File.join(base, '_layouts/') + "#{val}.html")
        self.read_yaml(File.join(base, '_layouts'), "#{val}.html")
      else
        self.read_yaml(File.join(base, '_layouts'), "default.html")
      end

      self.data["grouptype"] = type
      self.data[type] = val
    end
  end
end
