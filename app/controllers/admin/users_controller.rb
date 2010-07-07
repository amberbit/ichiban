# encoding: utf-8

class Admin::UsersController < Admin::BaseController
  before_filter :authenticate_admin!
  def index
    @users = User.find(:all, sort: "email asc")
  end
end