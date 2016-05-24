class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Authorization
  before_action :authenticate_user!
  before_action :set_email_host
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message

    if user_signed_in?
      if request.env['HTTP_REFERER']
        # Show error on referring page for logged in users
        redirect_to :back
      else
        redirect_to root_path
      end
    else
      # Redirect to login page otherwise
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # set correct url for all mails with link helpers
  def set_email_host
    ActionMailer::Base.default_url_options = { host: request.host_with_port }
  end
end
