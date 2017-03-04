class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
    else
      redirect_to new_user_session_path
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def after_sign_in_path_for(resource)
    if resource.admin? or resource.receptionist?
      '/dayLog/list'
    elsif resource.maid?
      '/roomStatus/list' 
    elsif resource.maitenance?
      '/issueLog/list'
    end
  end

end
