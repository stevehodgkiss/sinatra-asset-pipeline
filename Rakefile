task :environment do
  require './app'
end

namespace :assets do
  desc "Compile all the assets"
  task :precompile => :environment do
    App.sprockets.precompile("*")
  end

  desc "Remove compiled assets"
  task :clean => :environment do
    rm_rf App.sprockets.static_root, :secure => true
  end
end
