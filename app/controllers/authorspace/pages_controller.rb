class Authorspace::PagesController < Authorspace::BaseController

  def home
    @articles = Article.first(8)
  end
end
