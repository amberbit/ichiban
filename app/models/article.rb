# encoding: utf-8

class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :slug, type: String
  field :body, type: String

  belongs_to_related :user

  validates_presence_of :user_id, :title, :slug, :body
end
