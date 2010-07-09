# encoding: utf-8

class Admin::AssetsController < Admin::BaseController
  before_filter :find_asset, except: [:new, :create, :index]

  include Admin::GenericActions
  
  protected

  def find_asset;  @resource = Asset.find params[:id]; end
  def resource_class; Asset; end
end
