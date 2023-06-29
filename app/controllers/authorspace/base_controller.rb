class Authorspace::BaseController < ApplicationController
  before_action :authorize_author!

  def policy_scope(scope)
    super([:authorspace, scope])
  end

  def authorize(record, query = nil)
    super([:authorspace, record], query)
  end

  def current_author
    current_user
  end

  def current_namespace
    "authorspace"
  end

  def authorize_author!
    redirect_to root_path if !has_access?
  end

  def has_access?
    current_user.spaces.pluck(:name).include?("Authorspace")
  end

  rescue_from Pundit::NotAuthorizedError, with: :author_not_authorized
  def author_not_authorized
    flash[:alert] = "You are an author but not authorized to perform this action."
    redirect_back(fallback_location: authorspace_root_path)
    # redirect_to authorspace_root_path
  end
end
