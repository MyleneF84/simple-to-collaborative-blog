class Authorspace::ArticlesController < Authorspace::BaseController

  def index
    @articles = policy_scope(Article).eager_load(:authors).page(params[:page])
    if params[:tag]
      @title_tags = true
      @articles = Article.eager_load(:authors).tagged_with(params[:tag]).page(params[:page])
    end
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
    @comment = Comment.new
  end

  def new
    @article = Article.new
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
          Contribution.create!(author_id: current_author.id, article_id: @article.id)
      rescue => error
        puts "Error: #{error}"
        render :new and return
      else
        redirect_to authorspace_article_path(@article)
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
      redirect_to authorspace_article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize  @article
    @article.destroy
    redirect_to authorspace_articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :group_id, tag_list: [])
  end
end
