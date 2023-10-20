class PostsController < ApplicationController
    def create
        @pageTitle          = "Create Post"
        @urlLabel           = "URL"
        @titleLabel         = "Title"
        @bodyLabel          = "Body"
        @submitButton       = "Create"
    end

    def viewPost
        @pageTitle = "View Post"
        @pageTitle          = "Create Post"
        @urlLabel           = "URL"
        @titleLabel         = "Title"
        @bodyLabel          = "Body"
    end

    def view_all
        @pageTitle = "All Posts"
        @posts = Post.all
    end
end