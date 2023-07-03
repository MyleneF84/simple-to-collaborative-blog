class Authorspace::PagesController < Authorspace::BaseController

  def home
    @articles = Article.eager_load(:authors, :tags).first(8)
  end
end
