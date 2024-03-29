module Authors
  extend ActiveSupport::Concern

  included do
    after_action :clean_articles, only: :destroy
  end

  def show
    @author = Author.find(params[:id])
    authorize @author
    @comment = Comment.new
  end

  def destroy
    @author = current_author
    authorize @author
    if @author.update(type: "User")
      redirect_to root_path
    else
      redirect_to request.referrer
    end
  end

  private

  def author_params
    params.permit(:author).require(:email)
  end

  def clean_articles
    Article.joins(:contributions).where(group_id: nil).where(contributions: {author_id: current_author.id}).destroy_all
  end
end
