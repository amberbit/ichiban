# encoding: utf-8

class Path
  include Mongoid::Document
  include Mongoid::Timestamps
  include ModelWithKeywords
  field :request_path, type: String
  field :title, type: String
  field :priority, type: Integer, default: 1

  validates_presence_of :request_path
  validates_uniqueness_of :request_path
end