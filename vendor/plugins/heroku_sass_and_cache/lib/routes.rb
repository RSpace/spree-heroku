module HerokuSassAndCache
  module Routing
    module MapperExtensions
      def heroku_sass_and_cache
        return unless RAILS_ENV == 'production'
        
        @set.add_route("/javascripts/*file", {:controller => "heroku_sass_and_cache",
          :action => "javascripts",
          :conditions => { :method => :get }})
        @set.add_route("/stylesheets/*file", {:controller => "heroku_sass_and_cache",
          :action => "stylesheets",
          :conditions => { :method => :get }})
      end
    end
  end
end


debugger
ActionController::Routing::RouteSet::Mapper.send :include, HerokuSassAndCache::Routing::MapperExtensions 