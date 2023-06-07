class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    if params[:author_id]
      @author = Author.find(params[:author_id])
      @article.original_author = @author.id
    else
      @author = Author.new
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      if article_params[:original_author].present?
        Contribution.create!(author_id: article_params[:original_author], article_id: @article.id)
      else
        Author.create!(first_name: params[:author][:first_name], last_name: params[:author][:last_name])
        Contribution.create!(author_id: Author.last.id, article_id: @article.id)
      end
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :original_author)
  end
end
