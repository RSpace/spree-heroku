# HerokuSassAndCache

if RAILS_ENV == "production"
  %w{ controllers helpers }.each do |dir|
    path = File.join(File.dirname(__FILE__), 'app', dir)
    $LOAD_PATH << path
    ActiveSupport::Dependencies.load_paths << path
    ActiveSupport::Dependencies.load_once_paths.delete(path)
  end
end

require "routes"

if RAILS_ENV == "production"
  require "app/helpers/asset_tag_helper"

  if defined?(Sass::Plugin)
    Sass::Plugin.options[:css_location] = "#{Rails.root}/tmp/stylesheets"
    Sass::Plugin.options = {:always_update => false}
  end

  # Rails::Initializer.run do |config|
  #   config.after_initialize do
  #     # This should generate js and css on load of the plugin
  #     ActionController::Integration::Session.new.get '/'
  #   end
  # end
end