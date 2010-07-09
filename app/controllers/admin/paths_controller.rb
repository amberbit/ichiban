# encoding: utf-8

class Admin::PathsController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_path, except: [:new, :create, :index]

  include Admin::GenericActions

  def index; @resources = Path.all(sort: ["priority", "desc"]); end

  def show
    redirect_to [:edit, :admin, @resource]
  end
  
  protected

  def resource_class; Path; end

  def find_path;  @resource = Path.find params[:id]; end

end
