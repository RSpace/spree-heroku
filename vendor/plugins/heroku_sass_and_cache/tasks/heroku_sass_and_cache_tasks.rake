namespace :heroku_sass_and_cache do

  desc "Generate all Sass and Stylesheets - Run with RAILS_ENV=production rake"
  task :generate_style_sheets => :environment do
    Sass::Plugin.options[:css_location] = "#{RAILS_ROOT}/tmp/stylesheets"
    Sass::Plugin.options = {:always_update => true}
    Sass::Plugin.update_stylesheets
    
    # This should generate cached js or css if used
    ActionController::Integration::Session.new.get '/'
  end

end
