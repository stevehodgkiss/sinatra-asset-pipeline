require 'guard/rails-assets'
require 'guard/rails-assets/rails_runner'

# Monkey patch guard-rails-sprockets to hook into this custom setup
class ::Guard::RailsAssets::RailsRunner
  module AssetPipeline
    extend self
    
    def clean
      public_asset_path = File.expand_path("../public/assets", __FILE__)
      rm_rf public_asset_path, :secure => true
    end
    
    def precompile
      env = App.settings.sprockets
      manifest = {}
      target = Pathname.new(App.settings.assets_path)
      App.settings.precompile.each do |path|
        env.each_logical_path do |logical_path|
          if path.is_a?(Regexp)
            next unless path.match(logical_path)
          else
            next unless File.fnmatch(path.to_s, logical_path)
          end

          if asset = env.find_asset(logical_path)
            manifest[logical_path] = asset.digest_path
            filename = target.join(asset.digest_path)
            mkdir_p filename.dirname
            asset.write_to(filename)
            asset.write_to("#{filename}.gz") if filename.to_s =~ /\.(css|js)$/
          end
        end
      end
    end
  end
  
  def boot_rails
    @rails_booted ||= begin
      require './app'
      true
    end
  end
end

guard 'rails-assets' do
  watch(%r{^assets/.+$})
  watch('app.rb')
end