class AuthorsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def new
    @profile = Profile.new
    @author = Author.new
    authorize @author
  end

  def show
    @author = Author.find(params[:id])
    authorize @author
    @comment = Comment.new
  end

  def create
    @author = Author.new(author_params)
    authorize @author
    if @author.save
      redirect_to authorspace_author_path(@author)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.permit(:author).require(:email, :profile_id)
  end
end
