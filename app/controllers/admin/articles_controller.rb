class Admin::ArticlesController < Admin::BaseController
  before_filter :authenticate_admin!, only: [:publish, :unpublish]
  before_filter :find_article, except: [:new, :create, :index]
  before_filter :ensure_edit_permissions, only: [:edit, :update, :publish, :unpublish, :destroy]

  include Admin::GenericActions

  def publish
    @resource.published = true
    @resource.save
    redirect_to :back
  end

  def unpublish
    @resource.published = false
    @resource.save
    redirect_to :back
  end

  protected

  def resource_class; Article; end

  def find_article;  @resource = Article.find params[:id]; end

  def ensure_edit_permissions
    unless @resource.can_be_edited_by?(current_user)
      flash[:warning] = I18n.t("admin.permission_denied")
      redirect_to [:admin, @resource]
    end
  end
end