class ArticlesController < ApplicationController
  skip_before_action :authenticate_author!, only: %i[index show]

  def index
    @articles = policy_scope(Article).includes(:authors)
    if params[:tag]
      @title_tags = true
      @articles = Article.includes(:authors).tagged_with(params[:tag])
    end
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
    @comment = Comment.new
  end

  def new
    @article = Article.new
    # if params[:author_id]
    #   @author = Author.find(params[:author_id])
    #   @article.original_author = @author.id
    # else
    #   @author = Author.new
    # end
    @author = current_author
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    @author = current_author
    authorize @article

    Article.transaction do
      begin
        @article.save!
        # if article_params[:original_author].present?
          Contribution.create!(author_id: current_author.id, article_id: @article.id)
        # else
        #   Author.create!(first_name: params[:author][:first_name], last_name: params[:author][:last_name])
        #   Contribution.create!(author_id: Author.last.id, article_id: @article.id)
        # end
      rescue => error
        puts "Error: #{error}"
        # raise ActiveRecord::Rollback
        render :new and return
      else
        redirect_to article_path(@article)
      end
    end
  end

  def edit
    @article = Article.find(params[:id])
    authorize @article

  end

  def update
    @article = Article.find(params[:id])
    authorize @article

    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article

    @article.destroy
    redirect_to articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :original_author, tag_list: [])
  end
end
