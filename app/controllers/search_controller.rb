# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    if params[:search_type] == "Posts"
      @results = Post.where("title LIKE ?", "%#{params[:query]}%")
    elsif params[:search_type] == "Comments"
      @results = Comment.where("body LIKE ?", "%#{params[:query]}%")
    else
      @results = []
    end
  end
end
