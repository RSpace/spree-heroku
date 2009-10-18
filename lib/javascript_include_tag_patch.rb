module ActionView::Helpers::AssetTagHelper
  
  def javascript_include_tag_with_heroku_support(*sources)
     # :defaults makes it throw up on Heroku - don't ask me why
    sources = ['prototype', 'effects', 'dragdrop', 'controls', 'application'] if sources.flatten == [:defaults]
    javascript_include_tag_without_heroku_support(*sources)
  end
  alias_method_chain :javascript_include_tag, :heroku_support
  
end