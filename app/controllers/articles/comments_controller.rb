class Articles::CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  before_action :set_article, only: %i[create update new]

  def index
    @comments = Comment.all.page(params[:page]).per(params[:per])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.new(comment_params)
    # @comment = Comment.new(comment_params)
    # @comment.article_id = params[:article_id]
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
    if @comment.delete
      redirect_to :index
    else
      render status: :bad_request
    end
  end

  # Private method
  private

  def set_article
    @article = Aricle.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
