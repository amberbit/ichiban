# encoding: utf-8

class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end
end