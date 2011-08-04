require 'bundler'
Bundler.require

class App < Sinatra::Base
  set :root, File.expand_path("../", __FILE__)
  set :sprockets, Sprockets::Environment.new(root) { |env|
    env.static_root = File.join(root, 'public', 'assets')
  }
  
  configure do
    sprockets.append_path(File.join(root, 'app', 'assets', 'stylesheets'))
    sprockets.append_path(File.join(root, 'app', 'assets', 'javascripts'))
    sprockets.append_path(File.join(root, 'app', 'assets', 'images'))
  end
  
  helpers do
    def asset_path(source)
      settings.sprockets.path(source, true, "assets")
    end
  end
  
  get "/" do
    erb :index
  end
end