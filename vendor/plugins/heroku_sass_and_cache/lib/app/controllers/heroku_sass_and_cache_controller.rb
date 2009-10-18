class HerokuSassAndCacheController < ActionController::Base
  
  def stylesheets
    load_file_if_available('stylesheets', params[:file])
  end
  
  def javascripts
    load_file_if_available('javascripts', params[:file])
  end
  
  private
  
  def load_file_if_available(folder, file)
    tmp_file = File.join(Rails.root, 'tmp', folder, file)
    
    if FileTest.exists?(tmp_file)
      mtime = File.mtime(tmp_file).utc
      if stale?(:last_modified => mtime)
        render :file => tmp_file, :layout => false
      end
    else
      render :nothing => true, :status => 404
    end
  end
  
end