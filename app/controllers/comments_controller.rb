class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
  before_action :set_article, only: :new
  before_action :set_commentable, only: :create
  before_action :check_current_user, only: :create


  def new
    @comment = Comment.new
    @comment.user = current_user
    authorize @comment
  end

  def create
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
    authorize @comment

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
    params.require(:comment).permit(:content, :commentable_type, :commentable_id, :user_id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_commentable
    if params[:article_id].present?
      set_article_comment
    else
      set_author_comment
    end
  end

  def set_article_comment
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    authorize @comment
    @comment.user_id = current_user.id if current_user
    @comment.commentable = @article
  end

  def set_author_comment
    @author = Author.find(params[:author_id])
    @comment = Comment.new(comment_params)
    authorize @comment
    @comment.user_id = current_user.id if current_user
    @comment.commentable = @author
  end


  def check_current_user
    if !current_user
      session[:comment_content] = comment_params[:content]
      session[:commentable_type] = @comment.commentable_type
      session[:commentable_id] = @comment.commentable_id
      authenticate_user!
    end
  end
end
