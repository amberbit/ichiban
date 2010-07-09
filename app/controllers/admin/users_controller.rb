# encoding: utf-8

class Admin::UsersController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_user, except: [:new, :create, :index]

  include Admin::GenericActions
  
  def show
    redirect_to [:edit, :admin, @resource]
  end

  protected

  def find_user;  @resource = User.find params[:id]; end
  def resource_class; User; end
end