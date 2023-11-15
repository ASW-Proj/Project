class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  def home
    @posts = Post.all.order(created_at: :desc)
    #@postsControversial = Post.all.order() // me falta comments y votos
    @users = User.all
    if params[:sort] == 'newest'
      @posts = Post.all.order(created_at: :desc)
    elsif params[:sort] == 'oldest'
      @posts = Post.all.order(created_at: :asc)
    elsif params[:sort] == 'top'
      @posts = Post.all.order(created_at: :asc) #falta cambiar este
    elsif params[:sort] == 'controversial'
      @posts = Post.all.order(created_at: :asc) #falta cambiar este
    end

    @comments = Comment.all.order(created_at: :desc)
  end

  def homeNewest
    @posts = Post.all
  end
  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @post.points
  end

  # GET /posts/new
  def new
    @post = Post.new post_params
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    @post.update_column(:points, 0)
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def buscar
    if params[:busqueda].present?
      @posts = Post.where("title LIKE ?", "%#{params[:busqueda]}%")
    else
      @posts = []
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = Like.where(post_id: @post.id, user_id: current_user.id).first
    if @like.nil?
      @like = Like.new
      @like.post_id = params[:id]
      @like.user_id = current_user.id
      @post.increment!(:points)
      @post.save
      @like.save
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.html { notice 'Contribution was successfully liked' }
      format.json { head :no_content }
    end
  end
  
  def dislike
    @post = Post.find(params[:id])
    @like = Like.where(comment_id: @post.id, user_id: current_user.id).first
    if !@like.nil?
      @like.delete
      @post.update_column(:points, @post.points - 1)
      @post.save
      @like.save
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.html { notice 'Contribution was successfully disliked' }
      format.json { head :no_content }
    end
  end
  
  private
     #Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    def update_vote_count
      @post.update(votes_count: @post.votes.count)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.fetch(:post, {}).permit(:title, :url, :body, :community_id, :user_id)
    end


end
