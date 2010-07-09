class Admin::SnippetsController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_snippet, except: [:new, :create, :index]

  include Admin::GenericActions

  protected

  def find_snippet;  @resource = Snippet.find params[:id]; end
  def resource_class; Snippet; end
end