class PagesController < ApplicationController
  skip_before_action :authenticate_author!, only: :home

  def home
    @articles = Article.first(5)
  end
end
