# encoding: utf-8

module PathsHelper
  def recognize_path(path = request.path)
    Path.all(sort: ["priority", "desc"]).each do |p|
      if path =~ Regexp.new(p.request_path)
        return p
      end
    end
    return nil
  end

  def keywords_for_path(path = request.path)
    if found = recognize_path(path)
      return found.keywords
    else
      return []
    end
  end

  def title_for_path(path = request.path)
    if found = recognize_path(path)
      return found.title
    else
      return nil
    end
  end

  def description_for_path(path = request.path)
    if found = recognize_path(path)
      return found.description
    else
      return nil
    end
  end
end
