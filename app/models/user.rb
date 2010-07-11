# encoding: utf-8

require 'carrierwave/orm/mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :admin, type: Boolean, default: false
  attr_protected :admin

  validates_presence_of :name, :picture

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader
  has_many_related :articles

  def destroy
    articles.each { |a| a.destroy }
    super
  end

end
