# Top class for all controlers in the application
# to inherit from. User authentication is required
# and after logging in the user is redirected to his
# role-specific path.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from StandardError do
    render template: 'errors/internal_error', status: 500
  end

  rescue_from ActiveRecord::RecordNotFound do
    render template: 'errors/record_not_found', status: 404
  end

  def require_login(required_role)
    if !user_signed_in?
      redirect_to '/users/sign_in'
    elsif (current_user.role != required_role) && (current_user.role != 'admin')
      redirect_to get_user_home(current_user.role)
    end
  end

  def get_user_home(user_role)
    return case user_role
           when 'admin'
             '/dayLog/list'
           when 'receptionist'
             '/dayLog/list'
           when 'maid'
             '/roomStatus/list'
           when 'maitenance'
             '/issueLog/list'
           end
  end
end
