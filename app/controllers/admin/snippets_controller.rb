class Admin::SnippetsController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_snippet, except: [:new, :create, :index]

  def index
    @snippets = Snippet.find(:all, sort: "created_at desc")
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new params[:snippet]
    
    if @snippet.save
      redirect_to [:admin, @snippet]
    else
      flash[:warning] = I18n.t("admin.snippet.cannot_create")
      render action: "new"
    end
  end

  def update
    if @snippet.update_attributes params[:snippet]
      redirect_to [:admin, @snippet]
    else
      flash[:warning] = I18n.t("admin.snippet.cannot_update")
      render action: "edit"
    end
  end

  def destroy
    @snippet.destroy
    redirect_to [:admin, :snippets]
  end

  def show; end
  def edit; end

  protected

  def find_snippet;  @snippet = Snippet.find params[:id]; end
end