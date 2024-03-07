class BookmarksController < ApplicationController
  def index
    @bookmarks = policy_scope(Bookmark)
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    authorize @bookmark
    if @bookmark.save!
      redirect_to request.referrer + "#article__#{bookmark_params[:article_id]}"
    else
      redirect_to request.referrer
      flash[:alert] = "Article has not been bookmarked"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    @bookmark.destroy
    redirect_to request.referrer
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :article_id)
  end
end
