class Admin::ArticlesController < Admin::BaseController
  before_filter :authenticate_admin!, only: [:publish, :unpublish]
  before_filter :find_article, except: [:new, :create, :index]
  before_filter :ensure_edit_permissions, only: [:edit, :update, :publish, :unpublish, :destroy]

  def index
    @articles = Article.find(:all, sort: "created_at desc")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new params[:article]
    
    if @article.save
      redirect_to [:admin, @article]
    else
      flash[:warning] = I18n.t("admin.article.cannot_create")
      render action: "new"
    end
  end

  def update
    if @article.update_attributes params[:article]
      redirect_to [:admin, @article]
    else
      flash[:warning] = I18n.t("admin.article.cannot_update")
      render action: "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to [:admin, :articles]
  end

  def publish
    @article.published = true
    @article.save
    redirect_to :back
  end

  def unpublish
    @article.published = false
    @article.save
    redirect_to :back
  end

  def show; end
  def edit; end

  protected

  def find_article;  @article = Article.find params[:id]; end

  def ensure_edit_permissions
    unless @article.can_be_edited_by?(current_user)
      flash[:warning] = I18n.t("admin.permission_denied")
      redirect_to [:admin, @article]
    end
  end
end