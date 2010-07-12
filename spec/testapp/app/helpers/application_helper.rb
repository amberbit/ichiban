module ApplicationHelper
  def comment_form
    div_populate('new_comment_wrapper', new_comment_path(path: request.path))
  end

  def comments_list
    div_populate('comments_list_wrapper', comments_path(path: request.path))
  end

  def div_populate(id, path)
    content_tag :div, :id => id, "data-populate-with" => path do
      "<span class='loader'><span>Loading...</span></span>"
    end.html_safe
  end
end
