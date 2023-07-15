class Authorspace::CommentsController < Authorspace::BaseController
  before_action :check_current_author, only: :create

  include Comments

  def check_current_author
    if !current_author
      session[:comment_content] = comment_params[:content]
      session[:commentable_type] = @comment.commentable_type
      session[:commentable_id] = @comment.commentable_id
      authenticate_author!
    end
  end
end
