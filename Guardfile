require 'guard/rails-assets'
require 'guard/rails-assets/rails_runner'

# Monkey patch guard-rails-sprockets to hook into this custom setup
class ::Guard::RailsAssets::RailsRunner
  module AssetPipeline
    extend self
    
    def clean
      public_asset_path = App.sprockets.static_root
      rm_rf public_asset_path, :secure => true
    end
    
    def precompile
      App.sprockets.precompile("*")
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
  watch(%r{^app/assets/.+$})
  watch('app.rb')
end