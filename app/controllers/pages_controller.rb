class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @articles = Article.eager_load(:authors, :tags).first(8)
  end
end
