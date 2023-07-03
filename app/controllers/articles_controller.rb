class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  include ActionController::Live

  def index
    @articles = policy_scope(Article).eager_load(:authors).page(params[:page])
    if params[:tag]
      @title_tags = true
      @articles = Article.eager_load(:authors).tagged_with(params[:tag]).page(params[:page])
    end
    respond_to do |format|
      format.html
      format.csv { send_stream(filename: "articles-#{Date.today}.csv") do |stream|
          stream.write "id,Title,By:\n"
          @articles.find_each do |article|
            stream.write "#{article.id},#{article.title},#{article.authors.map(&:full_name).join('- ')}\n"
        end
      end
      }
      format.pdf { send_data Article.to_pdf, filename: "articles-#{Date.today}.pdf" }
    end
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
    @comment = Comment.new
  end

  def new
    @article = Article.new
    @author = current_user
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    @author = current_user
    authorize @article

    Article.transaction do
      begin
        @article.save!
          Contribution.create!(author_id: current_user.id, article_id: @article.id)
      rescue => error
        puts "Error: #{error}"
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
    params.require(:article).permit(:title, :content, tag_list: [])
  end
end
