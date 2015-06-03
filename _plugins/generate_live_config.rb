module Jekyll
  class ConfigurationGenerator < Generator
    def generate(site)
      if (ENV['JEKYLL_ENV'] == 'production')
        site.config['static_path'] = 'https://d1238u3jnb0njy.cloudfront.net'
        site.config['styles_path'] = 'https://d1238u3jnb0njy.cloudfront.net'
        site.config['scripts_path'] = 'https://d1238u3jnb0njy.cloudfront.net'
      end
    end
  end
end 