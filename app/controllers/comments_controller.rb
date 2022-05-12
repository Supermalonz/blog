class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy edit]
  before_action :set_article, only: %i[create update new edit]

  def index
    @comments = Comment.all.page(params[:page]).per(params[:per])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_path(params[:article_id])
    else
      render :edit
    end
  end

  def destroy
    if @comment.delete
      redirect_to articles_path
    else
      render :edit
    end
  end

  # Private method
  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.required(:comment).permit(:body, :title)
  end
end
