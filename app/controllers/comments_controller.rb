class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]

  def index
    @comments = Comment.all.page(params[:page]).per(params[:per])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.articles_id = params[:articles_id]
    if @comment.save
      redirect_to @comment
    else
      render :new
    end
  end

  def update
    @comment.content = comment_params[:content]
    if @comment.save
      render status: :ok
    else
      render status: :bad_request
    end
  end

  def destroy
    @comment.comments.map{ |comment| comment.delete}
    if @comment.delete
      render status: :ok
    else
      render status: :bad_request
    end
  end

  # Private method
  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :articles_id)
  end
end
