# encoding: utf-8

module ModelWithKeywords
  extend ActiveSupport::Concern
  included do
    field :keywords, type: Array

  end

  def keywords_string=(some_string = "")
    self.keywords = (some_string || "").split(/,( )*/).select {|el| el!=" " && el !=""}
  end

  def keywords_string
    keywords.join(", ")
  end
end