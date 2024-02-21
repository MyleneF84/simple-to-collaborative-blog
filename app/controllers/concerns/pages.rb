module Pages
  def home
    @articles = Article.eager_load(:authors, :tags).first(9)
    render 'pages/home'
  end
end
