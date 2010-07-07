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
end