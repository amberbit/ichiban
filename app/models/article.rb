# encoding: utf-8

class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include ModelWithKeywords
  include ContentProcessor
  
  field :title, type: String
  field :slug, type: String
  field :published, type: Boolean, default: false
  field :description, type: String
  process_content :body, :extended_body

  attr_protected :published

  belongs_to_related :user

  validates_presence_of :user_id, :title, :slug, :body
  validates_uniqueness_of :slug
  validates_length_of :description, :maximum => 155, :allow_blank => true

  def can_be_edited_by?(some_user)
    (published == false) || some_user.admin?
  end
end
