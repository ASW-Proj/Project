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

    def viewAll
        @pageTitle = "All Posts"
    end
end