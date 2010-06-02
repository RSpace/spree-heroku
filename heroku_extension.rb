# encoding: utf-8
# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class HerokuExtension < Spree::Extension
  version "0.2"
  description "Allows Spree to run on Heroku"
  url "http://github.com/chipiga/spree-heroku"
  
  def self.require_gems(config)
    config.gem 'aws-s3', :lib => "aws/s3"
  end

  def activate

    # Disable caching in the production environment
    ActionController::Base.perform_caching = false if RAILS_ENV == 'production'

  end
end
