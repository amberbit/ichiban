# encoding: utf-8

class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps
  include ContentProcessor

  field :name, type: String
  process_content :content

  validates_presence_of :name, :content
  validates_uniqueness_of :name
end