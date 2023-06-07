class CommentsController < ApplicationController
  before_action :set_article, only: %i[new]

  def new
    @author = Author.find(params[:author_id])
    @comment = Comment.new
  end

  def create
    if params[:article_id].present?
      set_article_comment
    else
      set_author_comment
    end

    if @comment.save
      if params[:article_id].present?
        redirect_to article_path(@article)
      else
        redirect_to author_path(@author)
      end
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if params[:article_id].present?
      set_article
      redirect_to article_path(@article)
    else params[:author_id].present?
      @author = Author.find(params[:author_id])
      redirect_to author_path(@author)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id, :author_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_article_comment
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    @comment.commentable_type = "Article"
    @comment.commentable_id = params[:article_id]
  end

  def set_author_comment
    @author = Author.find(params[:author_id])
    @comment = Comment.new(comment_params)
    @comment.commentable_type = "Author"
    @comment.commentable_id = params[:author_id]
  end
end
