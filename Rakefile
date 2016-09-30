require_relative 'lib/TypekitDomain'

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
end

desc "Build the site with the production configuration."
task :deploy do
    jekyll "build"
end

namespace :assets do
  desc "Rake task that Heroku runs to build static assets by defauly. "
  task :precompile => :deploy
end

namespace :typekit do
  task :add_domain do
    typekit = TypekitDomain.new
    typekit.add
  end

  task :remove_domain do
    typekit = TypekitDomain.new
    typekit.remove
  end
end

def jekyll(args)
    system("bundle exec jekyll #{args}") or exit!(1)
end

def clean
    puts "Cleaning previous builds"
    system("rm -Rf #{$build_dir}") or exit!(1)
end
