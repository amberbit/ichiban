# encoding: utf-8

require 'carrierwave/orm/mongoid'

class Asset
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  mount_uploader :file, AssetFileUploader
  validates_presence_of :title, :file
end