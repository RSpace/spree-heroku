# encoding: utf-8
Spree::FileUtilz.class_eval do
  class << self
    # Patch mirror_files method to be silent when using r/o Heroku FS
    alias_method :mirror_files_old, :mirror_files
    def mirror_files(source, destination, create_backups = false)
      return mirror_files_old(source, destination, create_backups) unless Rails.env == 'production'
      mirror_files_old(source, destination, create_backups) rescue true
    end
  end
end
