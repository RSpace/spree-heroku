# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class HerokuExtension < Spree::Extension
  version "0.1"
  description "Allows Spree to run on Heroku"
  url "http://casperfabricius.com"

  # Please use heroku/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate

    # Patch up for strange error in a call to javascript include tag
    require File.expand_path(File.dirname(__FILE__) + '/lib/javascript_include_tag_patch.rb')

    # Disable caching in the production environment
    ActionController::Base.perform_caching = false if RAILS_ENV == 'production'
    Spree::BaseController.perform_caching = false if RAILS_ENV == 'production'

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
