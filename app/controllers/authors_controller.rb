class AuthorsController < ApplicationController

  def new
    @author = Author.new
  end

  def show
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)
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
