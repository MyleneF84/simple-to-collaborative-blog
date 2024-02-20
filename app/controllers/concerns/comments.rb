module Comments
  extend ActiveSupport::Concern

  included do
    before_action :set_article, only: :new
    before_action :set_commentable, only: :create
  end

  def new
    @comment = Comment.new
    @comment.user = current_user
    authorize @comment
  end

  def create
    if @comment.save
      if params[:article_id].present?
        redirect_to polymorphic_path([namespace, @article])
      else
        redirect_to polymorphic_path([namespace, @author])
      end
    else
      flash[:notice] = "Content can't be blank :/ "
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    if params[:article_id].present?
      set_article
      redirect_to polymorphic_path([namespace, @article])
    else params[:author_id].present?
      @author = Author.find(params[:author_id])
      redirect_to polymorphic_path([namespace, @author])
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
end
