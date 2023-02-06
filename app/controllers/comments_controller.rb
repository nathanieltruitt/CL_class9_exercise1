class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(params[:post_id]), status: :see_other }
        format.json { render json: @comment, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.save
        format.html { redirect_to comments_path, status: :created, location: @comment }
        format.json { render json: @comment, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to post_path(params[:post_id]), status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
