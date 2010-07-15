# encoding: utf-8

class Path
  include Mongoid::Document
  include Mongoid::Timestamps
  include ModelWithKeywords
  field :request_path, type: String
  field :title, type: String
  field :priority, type: Integer, default: 1
  field :description, type: String
  validates_presence_of :request_path
  validates_uniqueness_of :request_path
  validates_length_of :description, :maximum => 155, :allow_blank => true
end
