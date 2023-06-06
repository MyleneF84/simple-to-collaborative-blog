class PagesController < ApplicationController
  def home
    @articles = Article.first(5)
  end
end
