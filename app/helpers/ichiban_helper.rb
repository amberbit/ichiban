# encoding: utf-8

module IchibanHelper
  def render_snippet(name)
    if snippet = Snippet.first(conditions: {name: name})
      snippet.content_processed.html_safe
    else
      "<!-- Snippet #{name} was not found! -->".html_safe
    end
  end
  def comment_form(path: nil)
    div_populate('new_comment_wrapper', new_comment_path(path: path || request.path))
  end

  def comments_list(path: nil)
    div_populate('comments_list_wrapper', comments_path(path: path || request.path))
  end

  def div_populate(id, path)
    content_tag :div, :id => id, "data-populate-with" => path do
      "<span class='loader'><span>Loading...</span></span>"
    end.html_safe
  end

end
