module Articles

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
    @author = current_user
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    @author = current_user
    authorize @article
    set_group

    Article.transaction do
      begin
        @article.save!
          Contribution.create!(author_id: current_user.id, article_id: @article.id)
      rescue => error
        puts "Error: #{error}"
        render :new and return
      else
        # redirect_to article_path(@article)
        redirect_to polymorphic_path(:current_namespace, @article)
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

    set_group

    if @article.update(article_params)
      # redirect_to article_path(@article)
      redirect_to polymorphic_path(:current_namespace, @article)

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
    params.require(:article).permit(:title, :content, :group_id, author_ids: [], tag_list: [])
  end

  def set_group
    if article_params[:author_ids] != [""]
      list = article_params[:author_ids].drop(1).reverse.map { |id| {author_id: id.to_i} }
      @group = Group.create!(memberships_attributes: list)
      @article.group = @group
    else article_params[:group_id].present?
      @article.group_id = article_params[:group_id]
    end
  end

end
