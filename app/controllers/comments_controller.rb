class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  include Comments

  def check_current_user
    if !current_user
      session[:comment_content] = comment_params[:content]
      session[:commentable_type] = @comment.commentable_type
      session[:commentable_id] = @comment.commentable_id
      authenticate_user!
    end
  end
end
