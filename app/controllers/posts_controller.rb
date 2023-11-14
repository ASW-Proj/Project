class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  def home
    @posts = Post.all
    @users = User.all
  end

  def homeNewest
    @posts = Post.all
  end
  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
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

  def vote_up
    @post = Post.find(params[:id])
    @vote = @post.votes.build(vote_type: 1, user_id: current_user.id)
    if @vote.save
      update_vote_count
    redirect_to @post
    else
      render json: { error: 'Error al votar' }, status: :unprocessable_entity

    end
  end

  def vote_down
    @post = Post.find(params[:id])
    @vote = @post.votes.build(vote_type: -1, user_id: current_user.id)
    if @vote.save
      update_vote_count
    redirect_to @post
    else
      render json: { error: 'Error al votar' }, status: :unprocessable_entity

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
