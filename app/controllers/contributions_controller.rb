class ContributionsController < ApplicationController

  def new
    @article = Article.find(params[:article_id])
    @contribution = Contribution.new
    authorize @contribution
  end

  def create
    @article = Article.find(params[:article_id])
    @contribution = Contribution.new(contribution_params)
    authorize @contribution
    @contribution.article = @article
    @contribution.author = current_user
    if @contribution.save
      @article.content = @contribution.content
      @article.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:author_id, :article_id, :content)
  end
end
