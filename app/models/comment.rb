# encoding: utf-8

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :name, type: String
  field :content, type: String
  field :path, type: String
  
  validates_presence_of :email, :name, :content, :path
end
