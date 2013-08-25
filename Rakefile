css_dir = "themes/base/public/base/css"

desc "Release to GitHub and Heroku"
task :deploy do
  system "git push heroku master && git push"
end

desc "Run the localhost server"
task :server do
  system "bundle exec shotgun config.ru"
end
task :s => :server

namespace :styles do

  desc "Clear the styles"
  task :clear => ["compile:clear"]

  desc "Compile new styles"
  task :compile => ["compile:default"]

  namespace :compile do

    task :clear do
      puts "*** Clearing styles ***"
      system "rm -Rfv #{css_dir}/*"
    end

    task :default => :clear do
      puts "*** Compiling styles ***"
      system "compass compile"
    end

    desc "Compile new styles for production"
    task :production => :clear do
      puts "*** Compiling styles ***"
      system "compass compile --output-style compressed --force"
    end

  end

end
