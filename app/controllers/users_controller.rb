class UsersController < ApplicationController
  def become_author
    @user = current_user
    authorize @user
    @user.type = "Author"
    if @user.save!
      flash[:notice] = "Welcome #{current_user.full_name}!!!"
      redirect_to authorspace_root_path
    end
  end
end
