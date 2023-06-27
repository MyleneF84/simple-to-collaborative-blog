class Authorspace::BaseController < ApplicationController
  # skip_before_action :authenticate_author!, only: :already_here?
  before_action :already_here?
  # before_action :authenticate_author!

  def policy_scope(scope)
    super([:authorspace, scope])
  end

  def authorize(record, query = nil)
    super([:authorspace, record], query)
  end

  # def pundit_user
  #   current_author
  # end

  def current_author
    current_user
  end

  def already_here?
    current_user.type == "Author"
  end

  def after_sign_in_path_for(resource)
    if session[:commentable_type]
      commentable = session[:commentable_type].constantize.find(session[:commentable_id])
      Comment.create!(content: session[:comment_content], commentable: commentable, author: resource )
      polymorphic_path(commentable)
    elsif
      authorspace_root_path
    else
      super
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :author_not_authorized
  def author_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: authorspace_root_path)
    # redirect_to authorspace_root_path
  end
end
