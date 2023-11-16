class SavedPostsController < ApplicationController
    def create
        @saved_post = SavedPost.new(post: post, user: current_user)
        
        respond_to do |format|
            if @saved_post.save
                format.html { redirect_to post_path(post), notice: "You have succesfully saved the post." }
            else
                format.html { redirect_to post_path(post), notice: "You can't save a post twice." }
            end
        end
    end

    def destroy
        post.saved_posts.find_by(user: current_user).destroy!      
        respond_to do |format|
            format.html { redirect_to posts_path, notice: "You have succesfully unsaved the post." }
        end
    end

    private

    def post
        @post ||= Post.find(params[:post_id])
    end
end