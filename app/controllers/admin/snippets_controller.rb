# encoding: utf-8

class Admin::SnippetsController < Admin::BaseController
  before_filter :authenticate_admin!
  before_filter :find_snippet, except: [:new, :create, :index]

  include Admin::GenericActions

  def index
    options = {sort: ["created_at", "desc"]}
    unless params[:query].blank?
      regexp = Regexp.new(params[:query], Regexp::IGNORECASE)
      options[:conditions] = {content: regexp}
    end
    @resources = Snippet.all(options)
  end

  protected

  def find_snippet;  @resource = Snippet.find params[:id]; end
  def resource_class; Snippet; end
end