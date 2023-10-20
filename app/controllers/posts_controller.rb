class PostsController < ApplicationController
    def create
        @pageTitle          = "Create Post"
        @urlLabel           = "URL"
        @titleLabel         = "Title"
        @bodyLabel          = "Body"
        @submitButton       = "Create"
    end
    def show
        @post= Post.find(params[:id])
        @comments= @post.comments
    end
end