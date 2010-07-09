# encoding: utf-8

class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps
  include ContentProcessor

  field :name, type: String
  field :content, type: String
  field :content_html, type: String

  validates_presence_of :name, :content
  validates_uniqueness_of :name
  process_content :content
end