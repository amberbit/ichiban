# encoding: utf-8

class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"

  protected
  def authenticate_admin!
    unless current_user.admin?
      flash[:notice] = t("admin.administrator_required")
      redirect_to :back
    end
  end
end
