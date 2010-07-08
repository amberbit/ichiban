# encoding: utf-8

class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :slug, type: String
  field :body, type: String
  field :extended_body, type: String
  field :body_html, type: String
  field :extended_body_html, type: String
  field :published, type: Boolean, default: false
  
  before_validation :process_content

  attr_protected :published

  belongs_to_related :user

  validates_presence_of :user_id, :title, :slug, :body

  private

  def process_content
    self.body_html = RDiscount.new(body || "", :smart, :filter_html).to_html
    self.extended_body_html = RDiscount.new(extended_body || "", :smart, :filter_html).to_html
  end
end
