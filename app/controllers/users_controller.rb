class UsersController < ApplicationController

  def become_author
    @user = current_user
    authorize @user
    @user.type = "Author"
    Access.create(user_id: current_user.id, space_id: 1)
    if @user.save
      UserMailer.with(user: @user).welcome_author.deliver_later
      flash[:notice] = "Welcome #{current_user.full_name}!!!"
      redirect_to authorspace_root_path
    end
  end
end
