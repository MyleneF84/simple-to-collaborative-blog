module Articles

  def index
    @bookmark = Bookmark.new
    @articles = policy_scope(Article).eager_load(:authors).page(params[:page])
    if Article::TAGS.include?(params[:query])
      @title_tags = true
      @articles = Article.eager_load(:authors).tagged_with(params[:query]).page(params[:page])
    else
      sql_subquery = "title LIKE :query OR content LIKE :query"
      @articles = @articles.where(sql_subquery, query: "%#{params[:query]}%").page(params[:page])
    end
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
    @comment = Comment.new
  end

  def new
    @article = Article.new
    authorize @article
    @author = current_user
    set_group
  end

  def create
    @article = Article.new(article_params)
    @author = current_user
    authorize @article

    Article.transaction do
      begin
        check_existing_group
        check_new_group
        @article.save!
          Contribution.create!(author_id: current_user.id, article_id: @article.id)
      rescue => error
        puts "Error: #{error} !!!"
        render :new, status: :unprocessable_entity and return
      else
        redirect_to polymorphic_path([namespace, @article])
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
      redirect_to polymorphic_path([namespace, @article])
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article
    @article.destroy
    redirect_to polymorphic_path([namespace, @article]), status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :rich_content, :group_id, group_attributes: [:id, :name, {memberships_attributes: [:author_id]}], tag_list: [], photos: [])
  end

  def set_group
    @group = @article.build_group
    # @group.memberships.build(author_id: current_author.id)
    3.times {@group.memberships.build}
  end

  def check_existing_group
    @article.group_id = article_params[:group_id] if !article_params[:group_id].nil?
  end

  def check_new_group
    if article_params[:group_id] == "" && article_params[:group_attributes][:memberships_attributes].to_h.values.pluck(:author_id).all?("")
      @article.group.delete
    end
  end

  # def is_bookmarked?
  #   Bookmark.where(user_id: current_user.id, article_id: self.id).present?
  # end
end
