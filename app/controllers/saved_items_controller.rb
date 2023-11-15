# app/controllers/saved_items_controller.rb
class SavedItemsController < ApplicationController
  before_action :authenticate_user!

  def save_post
    current_user.saved_posts.create(post_id: params[:post_id])
    redirect_to root_path, notice: 'Post saved successfully.'
  end

  def save_comment
    current_user.saved_comments.create(comment_id: params[:comment_id])
    redirect_to root_path, notice: 'Comment saved successfully.'
  end

  def list_saved_items
    @saved_posts = current_user.saved_posts.includes(:post)
    @saved_comments = current_user.saved_comments.includes(:comment)
  end
end
