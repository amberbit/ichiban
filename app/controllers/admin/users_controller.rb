# encoding: utf-8

class Admin::UsersController < Admin::BaseController
  before_filter :authenticate_admin!

  def index
    @users = User.find(:all, sort: "email asc")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to [:admin, @user]
    else
      flash[:notice] = t("admin.user.cannot_create")
      render action: "new"
    end
  end

  def edit
    find_user
  end

  def update
    find_user
    
    if @user.update_attributes params[:user]
      redirect_to [:edit, :admin, @user]
    else
      flash[:notice] = t("admin.user.cannot_update")
      render action: "edit"
    end
  end

  def show
    find_user
    redirect_to [:edit, :admin, @user]
  end

  def destroy
    find_user
    @user.destroy
    flash[:notice] = t("admin.user.deleted")
    redirect_to [:admin, :users]
  end

  protected

  def find_user;  @user = User.find params[:id]; end
end