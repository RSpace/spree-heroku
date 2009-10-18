module ActionView
  module Helpers
    module AssetTagHelper

      TMP_DIR = File.join(Rails.root, 'tmp')
  
      alias old_javascript_include_tag javascript_include_tag
      def javascript_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        cache   = options.delete("cache")
        recursive = options.delete("recursive")

        if ActionController::Base.perform_caching && cache
          joined_javascript_name = (cache == true ? "all" : cache) + ".js"
          joined_javascript_path = File.join(TMP_DIR, 'javascripts', joined_javascript_name)

          unless File.exists?(joined_javascript_path)
            write_asset_file_contents_to_tmp(joined_javascript_path, compute_javascript_paths(sources, recursive))
          end
          javascript_src_tag(joined_javascript_name, options)
        else
          return old_javascript_include_tag(sources)
        end
      end

      alias old_stylesheet_link_tag stylesheet_link_tag
      def stylesheet_link_tag(*sources)
        
        options = sources.extract_options!.stringify_keys
        cache   = options.delete("cache")
        recursive = options.delete("recursive")

        if ActionController::Base.perform_caching && cache
          joined_stylesheet_name = (cache == true ? "all" : cache) + ".css"
          joined_stylesheet_path = File.join(TMP_DIR, 'stylesheets', joined_stylesheet_name)

          unless File.exists?(joined_stylesheet_path)
            Sass::Plugin.update_stylesheets if defined?(Sass::Plugin)
            write_asset_file_contents_to_tmp(joined_stylesheet_path, compute_stylesheet_paths(sources, recursive))
          end
          stylesheet_tag(joined_stylesheet_name, options)
        else
          return old_stylesheet_link_tag(sources)
        end
      end

      def write_asset_file_contents_to_tmp(joined_asset_path, asset_paths)
        new_asset_paths = []
        asset_paths.each do |file|
          if FileTest.exists?(asset_file_path(file))
            new_asset_paths << asset_file_path(file)
          else
            tmp_file = File.join(TMP_DIR, file.split('?').first)
            if FileTest.exists?(tmp_file)
              new_asset_paths << tmp_file
            else
              new_asset_paths << asset_file_path(file)
            end
          end
        end

        FileUtils.mkdir_p(File.dirname(joined_asset_path))

        content = new_asset_paths.collect { |path| File.read(path) }.join("\n\n")

        File.open(joined_asset_path, "w+") { |cache| cache.write(content) }

        # Set mtime to the latest of the combined files to allow for
        # consistent ETag without a shared filesystem.
        mt = new_asset_paths.map { |p| File.mtime(p) }.max
        File.utime(mt, mt, joined_asset_path)
      end
    end
  end
end