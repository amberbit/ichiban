# encoding: utf-8

require 'carrierwave/orm/mongoid'

class Asset
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  mount_uploader :file, AssetFileUploader
  validates_presence_of :title, :file

  def destroy
    unless Article.count(conditions: {body: /image_asset\##{id}/}) > 0 ||
           Article.count(conditions: {extended_body: /image_asset\##{id}/}) > 0 ||
           Snippet.count(conditions: {content: /image_asset\##{id}/}) > 0
         return super
    end

    return false
  end
end