class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comment= Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @community = @post.community
    @user=current_user 
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @parent_comment = Comment.find_by(id: params[:parent_id])
    
    if @parent_comment.present?
      @comment = @parent_comment.replies.build(comment_params)
    else
      @comment = @post.comments.build(comment_params)
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def reply
    @post = Post.find(params[:post_id])
    @parent_comment = Comment.find(params[:parent_id])
    @comment = @post.comments.build(parent_id: @parent_comment.id)

    render 'new' 
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to show_post_path(@post), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
      @comment.destroy
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.json { head :no_content }
    end
  end

  def like
    @comment = Comment.find(params[:id])
    @like = Like.where(comment_id: @comment.id, user_id: current_user.id, like_type:1).first
    if @like.nil?
      @like = Like.new
      @like.comment_id = params[:id]
      @like.user_id = current_user.id
      @like.like_type=1
      @comment.increment!(:points)
      @comment.save
      @like.save
    else
      @like.delete
      @comment.update_column(:points, @comment.points - 1)
      @comment.save
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.html { notice 'Contribution was successfully liked' }
      format.json { head :no_content }
    end
  end
  
  def dislike
    @comment = Comment.find(params[:id])
    @like = Like.where(comment_id: @comment.id, user_id: current_user.id, like_type:0).first
    if @like.nil?
      @like = Like.new
      @like.comment_id = params[:id]
      @like.user_id = current_user.id
      @like.like_type=0
      @comment.update_column(:points, @comment.points - 1)
      @comment.save
      @like.save
    else
      @like.delete
      @comment.increment!(:points)
      @comment.save
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.html { notice 'Contribution was successfully disliked' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id, :community_id, :parent_id)
    end
end
