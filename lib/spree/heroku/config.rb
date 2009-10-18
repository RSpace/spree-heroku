module Spree
  module Heroku
    # Singleton class to access the Heroku configuration object (HerokuConfiguration.first by default) and it's preferences.
    #
    # Usage:
    # Spree::Heroku::Config[:foo] # Returns the foo preference
    # Spree::Heroku::Config[] # Returns a Hash with all the tax preferences
    # Spree::Heroku::Config.instance # Returns the configuration object (HerokuConfiguration.first)
    # Spree::Heroku::Config.set(preferences_hash) # Set the tax preferences as especified in +preference_hash+
    class Config
      include Singleton
      include PreferenceAccess
    
      class << self
        def instance
          return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
          HerokuConfiguration.find_or_create_by_name("Default heroku configuration")
        end
      end
    end
  end
end