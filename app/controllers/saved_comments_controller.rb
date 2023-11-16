class SavedCommentsController < ApplicationController
    def create
        @saved_comment = SavedComment.new(comment: comment, user: current_user)
        
        respond_to do |format|
            if @saved_comment.save
                format.html { redirect_to comment_path(comment), notice: "You have succesfully saved the comment." }
            else
                format.html { redirect_to comment_path(comment), notice: "You can't save a comment twice." }
            end
        end
    end

    def destroy
        comment.saved_comments.find_by(user: current_user).destroy!      
        respond_to do |format|
            format.html { redirect_to comments_path, notice: "You have succesfully unsaved the comment." }
        end
    end

    private

    def comment
        @comment ||= Post.find(params[:comment_id])
    end
end