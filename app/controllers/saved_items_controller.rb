# app/controllers/saved_items_controller.rb
class SavedItemsController < ApplicationController
  before_action :authenticate_user!



  def save_post
    @post = Post.find(params[:post_id])
    @user = current_user
    @saved_post = @user.saved_posts.find_by(post_id: @post.id)

    if @saved_post.nil?
      @saved_post = @user.saved_posts.build(saved_post_params)
      if @saved_post.save
        redirect_to root_path, notice: 'Post saved successfully.'
      else
      end
    else
      @saved_post.destroy
      redirect_to root_path, notice: 'Post removed from saved posts.'
    end
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

def saved_post
  params.require(:saved_post).permit(:user_id, :post_id)
end
