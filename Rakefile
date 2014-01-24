desc "Release to GitHub and Heroku"
task :deploy do
  system "git push heroku master && git push"
end

desc "Run the localhost server"
task :server do
  system "bundle exec foreman start"
end
task :s => :server

task :default do
  system "rake -T"
end
