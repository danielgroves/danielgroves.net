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
    jekyll "build --config _config.yml,_config_prod.yml"
end

task :build_all => :version do
    clean
    puts $linebreak
    puts "Building with all future and draft posts"
    jekyll "build --future --drafts"
end

task :deploy => :build do
    ENV['JEKYLL_ENV'] = 'production'
  
    if "#{ENV['CI_BUILD_REF_NAME']}" == "master"
        puts $linebreak
        puts "On master branch, will attempt to deploy"
        system "rsync -avz --omit-dir-times --no-perms --delete _site/ #{ENV['PROD_REMOTE']}"

        puts $linebreak
        puts "Attempting to push open Git Repo"
        system "git remote add github git@github.com:danielgroves/danielgroves.net.git"
        system "git reset HEAD --hard"
        system "git checkout master"
        system "git push github master"
    elsif "#{ENV['CI_BUILD_REF_NAME']}" == "new_design"
        puts $linebreak
        puts "On new_design branch, will attempt to deploy"
        system "rsync -avz --omit-dir-times --no-perms --delete _site/ #{ENV['STAGE_REMOTE']}"
    else
        puts $linebreak
        puts "Cannot deploy non-master branch"
    end
end

def jekyll(args)
    ENV['JEKYLL_ENV'] = 'development' unless ENV['JEKYLL_ENV'] == 'production'
    
    puts "Running under #{ENV['JEKYLL_ENV']} environment"
    system "jekyll #{args}"
end

def clean
    puts $linebreak
    puts "Cleaning previous builds"
    system "rm -Rf _site/"
end
