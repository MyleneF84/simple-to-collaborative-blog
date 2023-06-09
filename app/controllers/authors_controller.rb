class AuthorsController < ApplicationController
  skip_before_action :authenticate_author!, only: :show


  def new
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
      redirect_to author_path(@author)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.permit(:author).require(:first_name, :last_name)
  end
end
