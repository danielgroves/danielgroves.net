task default: %w[build]

task :version do
  jekyll "--version"
end

task :build => :version do
  clean
  jekyll "build"
end

task :build_all => :version do
  clean
  jekyll "build --future --drafts"
end

task :deploy => :build do
  system "rsync -avz --delete _site/ danielsgroves@danielgroves.net:temp/"
end

def jekyll(args)
  system "jekyll #{args}"
end

def clean
  system "rm -Rf _site/"
end
