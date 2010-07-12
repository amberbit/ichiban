# encoding: utf-8

class CommentsController < ApplicationController
  layout false

  def new
    @comment = Comment.new path: params[:path]
  end

  def create
    if request.xhr?
      @comment = Comment.new params[:comment]

      if @comment.save
        render partial: "success"
      else
        render partial: "failure"
      end
    else
      render :text => "oops!" #we're probably being spammed
    end
  end

  def index
    return if params[:path] == "/private-comments"
    
    @comments = Comment.find(:all, conditions: {path: params[:path]}, sort: ["created_at", "desc"])
  end
end

