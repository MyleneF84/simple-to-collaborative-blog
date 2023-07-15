class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  helper_method :current_author, :current_namespace

  after_action :verify_authorized, except: %i[index home], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def current_author
    current_user if current_user.is_a?(Author)
  end

  def current_namespace
    user_signed_in? ? "userspace" : "publicspace"
  end

  def namespace
    :authorspace if current_namespace != ("userspace" || "publicspace")
  end



  def after_sign_in_path_for(resource)
    if session[:commentable_type]
      commentable = session[:commentable_type].constantize.find(session[:commentable_id])
      # comment = Comment.create(content: session[:comment_content], commentable: commentable, user: resource )
      # comment ? polymorphic_path([namespace, commentable]) : root_path
      Comment.create(content: session[:comment_content], commentable: commentable, user: resource )
      polymorphic_path(commentable)
    elsif resource.is_a?(Author)
      authorspace_root_path
    else
      root_path
    end
  end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "Become an author to be authorized to perform this action."
    # redirect_back(fallback_location: root_path)
    # redirect_to authorspace_root_path
    redirect_to(request.referrer || root_path)
  end


  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
