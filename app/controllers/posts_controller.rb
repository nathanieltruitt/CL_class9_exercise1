class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    search = params[:search]
    @posts = search.nil? ? Post.paginate(params[:page]) : Post.where('title LIKE ?', "%#{search}%").paginate(params[:page])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, status: :created, location: @post }
        format.json { render json: @post, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_path(@post), status: :see_other, location: @post }
        format.json { render json: @post, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @post.destroy
      format.html { redirect_to posts_path, status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
