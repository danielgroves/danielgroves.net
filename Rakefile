require 'image_optim'

task default: %w[build]
$linebreak = "\n\n =========================\n"

task :version do
    jekyll "--version"
end

task :watch do
    jekyll "serve --watch --future --drafts"
end

task :serve do
    jekyll "serve"
end

task :build => :version do
    clean
    puts $linebreak
    if "#{ENV['CI_BUILD_REF_NAME']}" == "master"
      jekyll "build --config _config.yml,_config_production.yml"
    else
      jekyll "build --config _config.yml,_config_staging.yml"
    end
end

task :build_all => :version do
    clean
    puts $linebreak
    puts "Building with all future and draft posts"
    jekyll "build --future --drafts"
end

task :deploy do
    if "#{ENV['CI_BUILD_REF_NAME']}" == "master"
        puts $linebreak
        puts "On master branch, will attempt to deploy"
        system("rsync -avz --omit-dir-times --no-perms --delete _site/ #{ENV['PROD_REMOTE']}") or exit!(1)

        puts $linebreak
        puts "Attempting to push open Git Repo"
        system("git remote add github git@github.com:danielgroves/danielgroves.net.git")
        system("git reset HEAD --hard")
        system("git checkout master")
        system("git push github master")
    else
        puts $linebreak
        puts "On #{ENV['CI_BUILD_REF_NAME']} branch, will attempt to deploy to staging"
        system("rsync -avz --omit-dir-times --no-perms --delete _site/ #{ENV['STAGE_REMOTE']}") or exit!(1)
    end
end

namespace :optimisation do
  desc "Loops through the Jekyll assets directory and compresses every image it finds"
  task :compress_images do
    puts $linebreak
    puts "Compressing Images"

    optim = ImageOptim.new({
      pngout: false,
      svgo: false,
      threads: 8,
      jpegoptim: {
        strip: [],
        max_quality: 85
      },
      jpegtran: {
        progressive: true
      },
      optipng: {
        interlace: true
      },
      pngcrush: {
        blacken: false
      }
    })

    optim.optimize_images!(Dir["_site/assets/**/*.{jpeg,jpg,png}"]) do |f, s|
      if s
        puts "#{s} => succeeded"
      else
        puts "#{f} => failed"
      end
    end
  end
end

def jekyll(args)
    system("jekyll #{args}") or exit!(1)
end

def clean
    puts $linebreak
    puts "Cleaning previous builds"
    system("rm -Rf _site/") or exit!(1)
end
