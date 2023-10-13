class PostsController < ApplicationController
    def create
        @pageTitle          = "Create Post"
        @urlLabel           = "URL"
        @titleLabel         = "Title"
        @bodyLabel          = "Body"
        @submitButton       = "Create"
    end
end