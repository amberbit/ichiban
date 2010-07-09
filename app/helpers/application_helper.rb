# encoding: utf-8

module ApplicationHelper
  def render_snippet(name)
    if snippet = Snippet.first(conditions: {name: name})
      snippet.content_processed.html_safe
    else
      "<!-- Snippet #{name} was not found! -->".html_safe
    end
  end
end
