class Authorspace::CommentsController < Authorspace::BaseController
  before_action :set_article, only: :new
  before_action :set_commentable, only: :create
  before_action :check_current_author, only: :create

  def new
    @comment = Comment.new
    @comment.user = current_author
    authorize @comment
  end

  def create
    if @comment.save
      if params[:article_id].present?
        redirect_to authorspace_article_path(@article)
      else
        redirect_to authorspace_author_path(@author)
      end
    else
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment

    @comment.destroy
    if params[:article_id].present?
      set_article
      redirect_to authorspace_article_path(@article)
    else params[:author_id].present?
      @author = Author.find(params[:author_id])
      redirect_to authorspace_author_path(@author)
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
    @comment.user_id = current_author.id if current_author
    @comment.commentable = @article
  end

  def set_author_comment
    @author = Author.find(params[:author_id])
    @comment = Comment.new(comment_params)
    authorize @comment
    @comment.user_id = current_author.id if current_author
    @comment.commentable = @author
  end


  def check_current_author
    if !current_author
      session[:comment_content] = comment_params[:content]
      session[:commentable_type] = @comment.commentable_type
      session[:commentable_id] = @comment.commentable_id
      authenticate_author!
    end
  end
end
