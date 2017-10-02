require 'typekit_domain_manager'

task default: %w[dev:watch]

desc "Print the version of Jekyll being used."
task :version do
    jekyll "--version"
end

namespace :dev do
  desc "Run Jekyll with future posts and drafts, then automatically reload when saved."
  task :watch do
    clean
    jekyll "serve --config _config.yml,_config_dev.yml --watch --future --drafts"
  end

  desc "Build the Jekyll site using the development configuration."
  task :build do
    clean
    jekyll "build --config _config.yml,_config_dev.yml"
  end
end

desc "Build the site with the production configuration."
task :deploy do
  if (ENV['RACK_ENV'] == "staging")
    jekyll "build --config _config.yml,_config_staging.yml"
  else
    jekyll "build"
  end
end

namespace :assets do
  desc "Rake task that Heroku runs to build static assets by defauly. "
  task :precompile => :deploy
end

namespace :typekit do
  app_domain = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com"

  task :add_domain do
    typekit_domain_manager = get_domain_manager
    typekit_domain_manager.add_domain app_domain
  end

  task :remove_domain do
    typekit_domain_manager = get_domain_manager
    typekit_domain_manager.remove_domain app_domain
  end
end

def jekyll(args)
    system("bundle exec jekyll #{args}") or exit!(1)
end

def clean
    puts "Cleaning previous builds"
    system("rm -Rf #{$build_dir}") or exit!(1)
end

def get_domain_manager
  api_key = ENV['TYPEKIT_API_AUTH']
  kit_id = ENV['TYPEKIT_KIT_ID']

  TypekitDomainManager::Kit.new api_key, kit_id
end
