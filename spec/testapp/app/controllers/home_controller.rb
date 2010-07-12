# encoding: utf-8

class HomeController < ApplicationController
  def index
    render text: "Hello!"
  end
end

