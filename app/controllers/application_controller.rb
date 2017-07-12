# Top class for all controlers in the application
# to inherit from. User authentication is required
# and after logging in the user is redirected to his
# role-specific path.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |e|
    render :template => "errors/record_not_found"
  end

  rescue_from StandardError do |e|
    render :template => "errors/internal_error"
  end

  def authenticate_user!(options = {})
    if user_signed_in?
      super(options)
    else
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.admin? || resource.receptionist?
      '/dayLog/list'
    elsif resource.maid?
      '/roomStatus/list'
    elsif resource.maitenance?
      '/issueLog/list'
    end
  end
end
