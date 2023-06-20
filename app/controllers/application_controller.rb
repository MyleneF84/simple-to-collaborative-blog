class ApplicationController < ActionController::Base
  before_action :authenticate_author!

  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: %i[index home], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def after_sign_in_path_for(resource)
    if current_author
      authorspace_root_path
    else
      root_path
    end
  end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    # redirect_back(fallback_location: root_path)
    # redirect_to authorspace_root_path
    redirect_to(request.referrer || root_path)
  end


  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
